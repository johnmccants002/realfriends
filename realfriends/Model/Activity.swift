//
//  Activity.swift
//  realfriends
//
//  Created by John McCants on 9/5/22.
//

import Foundation
import Firebase

enum ActivityType: CaseIterable {
case newRespect
case newFollower
    
    var caption: String {
        switch self {
        case .newFollower: return "followed you"
        case .newRespect: return "respects your win"
        }
    }
}

struct Activity: Identifiable {
    var fromUid: String
    var toUid: String
    var type: String
    var id: String
    var timestamp: Timestamp
    var username: String
    var fullname: String
    var profileImageUrl: String
    var winId: String?
    
    init(dict: [String: Any]) {
        self.fromUid = dict["fromUid"] as? String ?? ""
        self.toUid = dict["toUid"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.timestamp = dict["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.winId = dict["winId"] as? String
        self.profileImageUrl = dict["profileImageUrl"] as? String ?? ""
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    

}

extension Activity: Equatable {
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}
