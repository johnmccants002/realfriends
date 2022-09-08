//
//  UploadWinViewModel.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//

import SwiftUI
import Firebase
class UploadWinViewModel: ObservableObject {
    @Binding var isPresented: Bool
    @Published var typeString = "Basic"
    @Published var currentTypeCount = 0
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        fetchTypeCount()
        
    }
    
    func uploadWin(caption: String, completion: @escaping((Error?) -> Void)) {
        guard let user = AuthViewModel.shared.user else { return }
        
        let docRef = COLLECTION_WINS.document()
        
        let dateString = Date().simpleDateString
        
        let lastWinRef = COLLECTION_LAST_WINS.document("\(dateString)\(user.id)\(typeString)")
        
        print("This is the last win ref \(dateString)\(user.id)\(typeString)")
        
        let data: [String: Any] = [
            "uid": user.id,
            "caption": caption,
            "fullname": user.fullname,
            "timestamp": Timestamp(date: Date()),
            "dateSeconds": Int(Date().timeIntervalSince1970),
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "likes": 0,
            "id": docRef.documentID,
            "type": typeString,
            "typeCount": self.currentTypeCount + 1,
            "simpleDateString": Date().simpleDateString
        ]
        
        
        docRef.setData(data) { err in
            lastWinRef.setData(data, completion: completion)
        }
        
    }
    
    func fetchTypeCount() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let countRef = COLLECTION_LAST_WINS.document("\(Date().simpleDateString)\(uid)\(typeString)")
        
        countRef.getDocument { snapshot, err in
            if let err = err {
                print("Error getting type count document: \(err.localizedDescription)")
            }
            guard let data = snapshot?.data() as? [String: Any] else { return }
            let win = Win(dict: data)
            
            self.currentTypeCount = win.typeCount
            print("This is the type count: \(win.typeCount)")
        }
        
       
    }
    
}
