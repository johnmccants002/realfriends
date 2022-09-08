//
//  WinDetailViewModel.swift
//  realfriends
//
//  Created by John McCants on 9/8/22.
//

import Foundation
import Firebase

class WinDetailViewModel: ObservableObject {
    @Published var win: Win?
    let id: String?
    
    init(id: String?) {
        self.id = id
        if let winId = id {
            self.fetchWin()
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
}
