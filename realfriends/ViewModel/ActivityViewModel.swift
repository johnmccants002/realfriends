//
//  ActivityViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/5/22.
//

import Foundation

class ActivityViewModel: ObservableObject {
    @Published var activities = [Activity]()
    
    init() {
        fetchActivity()
    }
    
    func fetchActivity() {
        
    }
}

