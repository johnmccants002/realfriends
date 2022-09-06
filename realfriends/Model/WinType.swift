//
//  WinType.swift
//  realfriends
//
//  Created by John McCants on 9/6/22.
//

import Foundation
import Firebase

struct WinType: Identifiable {
    
    let typeString: String
    let lastUsed: Timestamp
    let id: String
    
    init(dict: [String: Any]) {
        self.typeString = dict["typeString"] as? String ?? ""
        self.lastUsed = dict["lastUsed"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dict["id"] as? String ?? ""
    }
}
