//
//  WinDetailView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI
import Kingfisher

struct WinDetailView: View {
    let win: Win
    @ObservedObject var viewModel : UserViewModel
    @State var showingProfile = false

    
    init(win: Win) {
        self.win = win
        self.viewModel = UserViewModel(id: win.uid)
        
    }
    var body: some View {
                    VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    KFImage(URL(string: win.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 56, height: 56)
                        .cornerRadius(28)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(win.fullname)
                            .font(.system(size: 14, weight: .semibold))
                        Text("@\(win.username)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .onTapGesture {
                    if viewModel.user != nil {
                        showingProfile = true
                    }
                }
                .background(
                    NavigationLink(isActive: $showingProfile, destination: {
                        if let user = viewModel.user {
                            UserProfileView(user: user)
                        }
                    }, label: {
                        EmptyView()
                    })
                )
                
                
                
                
                Text(win.caption)
                    .font(.system(size: 22))
                
                Text(win.detailedTimestampString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Divider()
                
                        if AuthViewModel.shared.userSession?.uid == win.uid {
                            HStack(spacing: 12) {
                                
                                HStack(spacing: 4) {
                                    Text("0")
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                    Text("Respects")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    
                                }
                                
                                Spacer()
                                
                            }
                            Divider()
                        }
                
               
                
                WinActionView(win: win)
                
                Spacer()
                
            }.padding()}
        
    
        
    
}


