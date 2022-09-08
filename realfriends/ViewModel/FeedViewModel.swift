//
//  FeedViewModel.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//


import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    @Published var wins = [Win]()
    @Published var endReached = false
    @Published var lastFetch = Int(Date().timeIntervalSince1970)
    
    
    init() {
        fetchLastWins()
    }
    
    func fetchWins() {
        COLLECTION_WINS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
           
            
            let fetchedWins = documents.map({ Win(dict: $0.data()) })
            
            self.wins = fetchedWins.sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
        
        }
    }
    
    func fetch10Wins() {
        COLLECTION_WINS.order(by: "dateSeconds", descending: true).limit(to: 10).getDocuments { snapshot, err in
            
            guard let documents = snapshot?.documents else { return }
            
            let fetchedWins = documents.map({ Win(dict: $0.data())})
            
            self.wins = fetchedWins.sorted(by: { $0.timestamp.seconds > $1.timestamp.seconds
            })
        }
    }
    
    func fetchMoreWins() {
        let now = Int(Date().timeIntervalSince1970)
        let difference = now - lastFetch
        if endReached {
            return
        }
        print("Function called. Win Count: \(self.wins.count)")
        guard let lastWin = self.wins.last?.dateSeconds else { return }
        COLLECTION_WINS.order(by: "dateSeconds", descending: true).start(after: [lastWin]).limit(to: 10).getDocuments{ snapshot, err in
            self.lastFetch = Int(Date().timeIntervalSince1970)
            guard let documents = snapshot?.documents else { return }
            if documents.count == 0 {
                self.endReached = true
            }
            
            let fetchedWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
        
            self.wins.append(contentsOf: fetchedWins)
        }
    }
    
    func fetchLastWins() {
        guard let followingList = AuthViewModel.shared.following else { return }
        
        COLLECTION_LAST_WINS.order(by: "dateSeconds", descending: true).whereField("uid", in: followingList).limit(to: 10).getDocuments { snapshot, err in
            guard let documents = snapshot?.documents else { return }
            let fetchedWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
            self.wins = fetchedWins
            
            
        }
        
    }
    
    func fetchMoreLastWins() {
        let now = Int(Date().timeIntervalSince1970)
        let difference = now - lastFetch
        if endReached {
            return
        }
        guard let followingList = AuthViewModel.shared.following else { return }
        guard let lastWin = self.wins.last?.dateSeconds else { return }
        
        COLLECTION_LAST_WINS.order(by: "dateSeconds", descending: true).whereField("uid", in: followingList).start(after: [lastWin]).limit(to: 10).getDocuments { snapshot, err in
            self.lastFetch = Int(Date().timeIntervalSince1970)
            guard let documents = snapshot?.documents else { return }
            if documents.count == 0 {
                self.endReached = true
            }
            let fetchedWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
            self.wins = fetchedWins
            
            
        }
        
    }
}





