//
//  realfriendsApp.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      let settings = Firestore.firestore().settings
      settings.host = "localhost:8080"
      settings.isPersistenceEnabled = false
      settings.isSSLEnabled = false
      Firestore.firestore().settings = settings
      
//     Storage.storage().useEmulator(withHost:"localhost", port:9199)

    return true
  }
}

@main
struct realfriendsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }}
