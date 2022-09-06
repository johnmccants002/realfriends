//
//  Select.swift
//  realfriends
//
//  Created by John McCants on 9/6/22.
//

import Foundation
import Firebase


class SelectTypesViewModel {
    var types = [WinType]()
    
    init() {
        fetchUserTypes()
    }
    
    func fetchUserTypes() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let typesRef = COLLECTION_USERS.document(uid).collection("types")
        
        typesRef.getDocuments { snapshot, err in
            if let err = err {
                print("Error fetching User Types: \(err.localizedDescription)")
            }
            
            let documents = snapshot?.documents
            var fetchedTypes = [WinType]()
            documents?.forEach({ doc in
                let type = WinType(dict: doc.data())
                fetchedTypes.append(type)
            })
            self.types = fetchedTypes
            
        }
        
    }
    
    func addNewUserType(typeString: String) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let typesRef = COLLECTION_USERS.document(uid).collection("types")
        let typesDoc = typesRef.document()
        let typeData = ["typeString": typeString, "lastUsed": Timestamp(date: Date())] as [String : Any]
        
        typesDoc.setData(typeData)
        
        
    }
    
    func deleteUserType(winType: WinType) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let typesRef = COLLECTION_USERS.document(uid).collection("types")
        typesRef.document(winType.id).delete()
        
    }
    
    
}
