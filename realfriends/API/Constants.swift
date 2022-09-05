//
//  Constants.swift
//  realfriends
//
//  Created by John McCants on 8/18/22.
//

import Foundation
import Firebase

let COLLECTION_WINS = Firestore.firestore().collection("posts")
let COLLECTION_SORTED_WINS = Firestore.firestore().collection("sortedwins")
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")

