//
//  UserViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/7/22.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    var user: User?
    let id: String
    
    init(id: String) {
        self.id = id
        fetchUser(id: id)
    }
    
    func fetchUser(id: String) {

        Firestore.firestore().collection("users").document(id).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dict: data)

        }
    }

}
