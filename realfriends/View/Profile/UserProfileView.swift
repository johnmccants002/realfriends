//
//  UserProfileView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct UserProfileView: View {
    @State var selectedFilter: WinFilterOptions = .wins
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(user: user, viewModel: viewModel)
                    .padding()
                FilterButtonView(selectedOption: $selectedFilter)
         
                
                ForEach(viewModel.userWins) { win in
                    WinCell(win: win)
                        .padding()
                }
                
            }
            .navigationTitle(user.username)
        }
    }
}


