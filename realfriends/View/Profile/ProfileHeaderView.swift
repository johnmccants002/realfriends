//
//  ProfileHeaderView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    var body: some View {
        VStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(60)
                .shadow(color: .black, radius: 6, x: 0.0, y: 0.0)
            
            Text(user.fullname)
                .font(.system(size: 16, weight: .semibold))
            Text(user.username)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Web and iOS dev trying to build cool things and make a living.")
            
            HStack(spacing: 40) {
                VStack {
                    Text("\(viewModel.user.stats.followers)")
                        .font(.system(size: 16))
                        .bold()
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Text("\(viewModel.user.stats.following)")
                        .font(.system(size: 16))
                        .bold()
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Spacer()
            
        }
    
    }
}

