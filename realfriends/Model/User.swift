//
//  User.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import Foundation
import Firebase

struct User: Identifiable {
    let id, username, profileImageUrl, fullname, email: String
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    var stats: UserStats
    
    var isFollowed: Bool = false
    
    init(dict: [String: Any]) {
        self.id = dict["uid"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.profileImageUrl = dict["profileImageUrl"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0, realFriends: 0)
        
        
    }
    
}

struct UserStats {
    let followers: Int
    let following: Int
    let realFriends: Int
}
