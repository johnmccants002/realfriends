//
//  AuthViewModel.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth



class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    @Published var following: [String]?
    
   
    
    static let shared = AuthViewModel()
    
    init() {
        Auth.auth().useEmulator(withHost:"localhost", port:9099)
        
        userSession = Auth.auth().currentUser
        fetchUser()
        fetchFollowing()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Successfully logged in")
            self.userSession = result?.user
            self.fetchUser()
            
        }
        
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        print(email, password, username, fullname, profileImage.pngData() ?? "image data")
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child(filename)
//        let storageRef = Storage.storage(url: "gs://realfriends-210b9.appspot.com").reference().child(filename)
        storageRef.putData(imageData, metadata: nil) { _, error in
            
            if let error = error {
                print("DEBUG: Error in imagedata \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) {
                    result, error in
                    if let error = error {
                        print("DEBUG: Error in create user \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data = [
                        "email": email,
                        "fullname": fullname,
                        "username": username,
                        "profileImageUrl": profileImageUrl,
                        "uid": user.uid
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        print("DEBUG: Successfully uploaded user data")
                        self.userSession = user
                        self.fetchUser()
                    }


                }
            }
        }

    }
    
    func signout() {
        self.userSession = nil
        user = nil
        try? Auth.auth().signOut()
        
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dict: data)
           
        }
    }
    
    func fetchFollowing() {
        guard let uid = userSession?.uid else { return }
        print("Uid: \(uid)")
        var fetchedFollowing = [String]()
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, err in
            print("getting documents")
            
            guard let documents = snapshot?.documents else { return }
            print(documents, "These are the documents")
            
            
            for doc in documents {
                fetchedFollowing.append(doc.documentID)
            }
            self.following = fetchedFollowing
            print("Following: \(fetchedFollowing)")
        }
    }
}


