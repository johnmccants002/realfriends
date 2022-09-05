//
//  ProfileViewModel.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//

import Foundation
import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var userWins = [Win]()
    @Published var respectedWins = [Win]()
    
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserWins()
        fetchRespectedWins()
        fetchUserStats()
    }
    
//    func tweets(forFilter filter: TweetFilterOptions) -> [Tweet] {
//        switch filter {
//        case .tweets:
//            return self.userTweets
//        case .likes:
//            return self.likedTweets
//        case.replies:
//            return [Tweet]()
//        }
//    }
//
    
}

// MARK: - API

extension ProfileViewModel {

    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")

        followingRef.document(user.id).setData([:]) { _ in
            followersRef.document(currentUid).setData([:]) { _ in
                self.user.isFollowed = true
            }
        }


    }

    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")

        followingRef.document(user.id).delete { _ in
            followersRef.document(currentUid).delete { _ in
                self.user.isFollowed = false
            }
        }

    }

    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard !user.isCurrentUser else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        followingRef.document(user.id).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            self.user.isFollowed = isFollowed
        }

    }
    
    func fetchUserWins() {
        COLLECTION_WINS.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.userWins = documents.map({ Win(dict: $0.data()) })
        }
    }
    
    func fetchRespectedWins() {
        var wins = [Win]()
        COLLECTION_USERS.document(user.id).collection("user-respects").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let winIDs = documents.map({ $0.documentID })

            winIDs.forEach { id in
                COLLECTION_WINS.document(id).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let win = Win(dict: data)
                    wins.append(win)
                    guard wins.count == winIDs.count else { return }
                    self.respectedWins = wins

                }
            }

        }
    }

    func fetchUserStats() {
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        
        
        followersRef.getDocuments { snapshot, _ in
            guard let followerCount = snapshot?.documents.count else { return }

            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                let stats = UserStats(followers: followerCount, following: followingCount)
                self.user.stats = stats
            }
        }
    }

    
}

