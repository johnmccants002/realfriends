//
//  Win.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import Firebase

struct Win: Identifiable {
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let caption: String
    let respects: Int
    let uid: String
    let timestamp: Timestamp
    let dateSeconds: Int
    let type: String
    let typeCount: Int
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        self.profileImageUrl = dict["profileImageUrl"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.respects = dict["respects"] as? Int ?? 0
        self.uid = dict["uid"] as? String ?? ""
        self.caption = dict["caption"] as? String ?? ""
        self.timestamp = dict["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.dateSeconds = dict["dateSeconds"] as? Int ?? Int(Date().timeIntervalSince1970)
        self.type = dict["type"] as? String ?? "Basic"
        self.typeCount = dict["typeCount"] as? Int ?? 0
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var detailedTimestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: timestamp.dateValue())
    }
    
    var simpleDateString: String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
        let date = Date()
        let yesterday = date.dayBefore
        let todaysDateString = dateFormatter.string(from: date)
        let yesterdayDateString = dateFormatter.string(from: yesterday)
        let winDateString = dateFormatter.string(from: self.timestamp.dateValue())
        if todaysDateString == winDateString {
            return "Today"
        } else if yesterdayDateString == winDateString {
            return "Yesterday"
        } else {
            return dateFormatter.string(from: self.timestamp.dateValue())
        }
        
    }
}

extension Win: Equatable {
    static func == (lhs: Win, rhs: Win) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Win: Hashable {
    
}


