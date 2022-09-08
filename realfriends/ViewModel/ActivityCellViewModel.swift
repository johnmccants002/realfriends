//
//  WinDetailViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/8/22.
//

import Foundation
import Firebase

class ActivityCellViewModel: ObservableObject {
    @Published var win: Win?
    let id: String?
    let fromUid: String?
    var user: User?
    
    init(id: String?, fromUid: String?) {
        self.id = id
        self.fromUid = fromUid
        if let winId = id {
            self.fetchWin()
        }
        
        if fromUid != nil {
            self.fetchUser()
        }
    }
    
    
    func fetchWin() {
        COLLECTION_WINS.whereField("id", isEqualTo: id).getDocuments { snapshot, err in
            guard let documents = snapshot?.documents else { return }
            
            guard let firstDoc = documents.first else { return }
            let win = Win(dict: firstDoc.data())
            
            self.win = win
        }
        
    }
    
    func fetchUser() {
        guard let uid = fromUid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, err in
            guard let data = snapshot?.data() else { return }
            self.user = User(dict: data)
        }
    }
}
