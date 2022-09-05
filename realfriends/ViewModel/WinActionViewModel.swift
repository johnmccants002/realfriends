//
//  WinActionViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/4/22.
//

import Foundation
import Firebase

class WinActionViewModel: ObservableObject {
    let win: Win
    @Published var didRespect = false
    
    init(win: Win) {
        self.win = win
    }
    
    func respectWin() {
        guard let uid = AuthViewModel.shared.userSession?.uid, let user = AuthViewModel.shared.user else { return }
        
        let winRespectsRef = COLLECTION_WINS.document(win.id).collection("win-respects")
        let userRespectsRef = COLLECTION_USERS.document(uid).collection("user-respects")
        let activityRef = COLLECTION_USERS.document(win.uid).collection("user-activity")
        
        COLLECTION_WINS.document(win.id).updateData(["respects": win.respects + 1])
        
        winRespectsRef.document(uid).setData([:]) { _ in
            userRespectsRef.document(self.win.id).setData([:]) { _ in
                self.didRespect = true
            }
            
            let activityDoc = activityRef.document("\(self.win.id)\(uid)")
            let data = [
                "fromUid": uid,
                "toUid": self.win.uid,
                "timestamp": Timestamp(date: Date()),
                "type": "newRespect",
                "id": activityDoc.documentID,
                "profileImageUrl": user.profileImageUrl,
                "username": user.username,
                "fullname": user.fullname,
                "winId": self.win.id
            ]
            activityDoc.setData(data)
        }
    }
    
    func unrespectWin() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let winRespectsRef = COLLECTION_WINS.document(win.id).collection("win-respects")
        let userRespectsRef = COLLECTION_USERS.document(uid).collection("user-respects")
        let activityRef = COLLECTION_USERS.document(win.uid).collection("user-activity")
        COLLECTION_WINS.document(win.id).updateData(["respects": win.respects - 1])
        
        winRespectsRef.document(uid).delete { _ in
            userRespectsRef.document(self.win.id).delete { _ in
                self.didRespect = false
            }
            
            activityRef.document("\(self.win.id)\(uid)").delete()
        }
    }
    
    func checkIfUserRespectedWin() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let userRespectsRef = COLLECTION_USERS.document(uid).collection("user-respects").document(win.id)
        
        userRespectsRef.getDocument { snapshot, err in
            if let err = err {
                print("Error getting user respected win: ", err)
            }
            guard let didRespect = snapshot?.exists else { return }
            self.didRespect = didRespect
        }
    }
}
