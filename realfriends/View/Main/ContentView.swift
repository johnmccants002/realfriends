//
//  ContentView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selection = 0
    let titles = ["RealFriends", "Activity", "Profile"]
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    TabView(selection: $selection) {
                        FeedView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Feed")
                            }.tag(0)
                        ActivityView()
                            .tabItem {
                                Image(systemName: "heart")
                                Text("Activity")
                            }.tag(1)
                        if let user = viewModel.user {
                            UserProfileView(user: user)
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }.tag(2)
                        }
                        
                    }
                    .navigationTitle(titles[selection])
                    .navigationBarItems(leading: Button(action: {
                        print("Profile button tapped")
                        viewModel.signout()
                    }, label: {
                        Image("johncartoon")
                            .resizable()
                            .clipped()
                            .frame(width: 32, height: 32)
                            .cornerRadius(16)
                    }))
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
