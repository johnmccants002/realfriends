//
//  TypeFeedViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/7/22.
//

import Foundation

class TypeFeedViewModel: ObservableObject {
    @Published var typeWins = [Win]()
    @Published var endReached = false
    @Published var typeString : String
    @Published var uid: String
    @Published var win: Win
    
    init(typeString: String, uid: String, win: Win) {
        self.typeString = typeString
        self.uid = uid
        self.win = win
//        fetchTypeWins()
        print("Initialized: \(win.type) typeString: \(typeString)")
        fetchFirstTypeWins()
        
    }
    
    func fetchTypeWins() {
        
        COLLECTION_WINS.order(by: "dateSeconds", descending: true).whereField("uid", isEqualTo: uid).whereField("type", isEqualTo: typeString).limit(to: 20).getDocuments { snapshot, errr in
            
            guard let documents = snapshot?.documents else { return }
            let fetchedTypeWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
            self.typeWins = fetchedTypeWins
            
        }
    }
    
    func fetchMoreTypeWins() {
        if endReached {
            return
        }
        
        guard let lastTypeWin = self.typeWins.last?.dateSeconds else { return }
        
        COLLECTION_WINS.order(by: "dateSeconds", descending: true).whereField("uid", isEqualTo: uid).whereField("type", isEqualTo: typeString).start(after: [lastTypeWin]).limit(to: 20).getDocuments { snapshot, err in
            
            guard let documents = snapshot?.documents else { return }
            if documents.count == 0 {
                self.endReached = true
            }
            
            let fetchedTypeWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
            
            self.typeWins.append(contentsOf: fetchedTypeWins)
            
        }
        
    }
    
    func fetchFirstTypeWins() {
    
     
        print("This is the tapped win: \(win.caption)")
        
        COLLECTION_WINS.whereField("uid", isEqualTo: win.uid).whereField("type", isEqualTo: win.type).whereField("simpleDateString", isEqualTo: win.dateString).getDocuments { snapshot, err in
            print("This is the count: ", snapshot?.documents.count)
            
            guard let documents = snapshot?.documents else { return }
            let fetchedTypeWins = documents.map({Win(dict: $0.data())}).sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
            
            print("Fetched Type Wins", fetchedTypeWins)
            
            self.typeWins = fetchedTypeWins
        }
        
    }
    
}
