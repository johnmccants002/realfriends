//
//  UploadWinViewModel.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//

import SwiftUI
import Firebase
class UploadWinViewModel: ObservableObject {
    @Binding var isPresented: Bool
    @Published var typeString = "Basic"
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func uploadWin(caption: String, completion: @escaping((Error?) -> Void)) {
        guard let user = AuthViewModel.shared.user else { return }
        
        let docRef = COLLECTION_WINS.document()
        
        let data: [String: Any] = [
            "uid": user.id,
            "caption": caption,
            "fullname": user.fullname,
            "timestamp": Timestamp(date: Date()),
            "dateSeconds": Int(Date().timeIntervalSince1970),
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "likes": 0,
            "id": docRef.documentID
        ]
        
        docRef.setData(data, completion: completion)
        
    }
    
}
