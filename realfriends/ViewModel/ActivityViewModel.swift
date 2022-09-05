//
//  ActivityViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/5/22.
//

import Foundation
import Firebase

class ActivityViewModel: ObservableObject {
    @Published var activities = [Activity]()
    
    init() {
        fetchActivity()
    }
    
    func fetchActivity() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let activityRef = COLLECTION_USERS.document(uid).collection("user-activity")
        
        activityRef.getDocuments { snapshot, err in
            if let err = err {
                print("Error fetching Activity: \(err.localizedDescription)")
            }
            
            guard let documents = snapshot?.documents else { return }
            let fetchedActivities = documents.map({Activity(dict: $0.data())})
            
            self.activities = fetchedActivities.sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
        }
        
    }
    
    func fetchMoreActivity() {
        
    }
}

