//
//  TypeFeedView.swift
//  realfriends
//
//  Created by John McCants on 9/7/22.
//

import SwiftUI

struct TypeFeedView: View {
    @ObservedObject var viewModel: TypeFeedViewModel
    let uid: String
    let typeString: String
    let win: Win
    
    init(uid: String, typeString: String, win: Win) {
        self.uid = uid
        self.typeString = typeString
        self.win = win
        self.viewModel = TypeFeedViewModel(typeString: typeString, uid: uid, win: win)
        
    }

    var body: some View {
        List(viewModel.typeWins.enumerated().map({$0}), id: \.1.self) {
            id, win in
            
            if (id > 0) {
                if (viewModel.typeWins[id - 1].simpleDateString != win.simpleDateString) {
                    Text(win.simpleDateString)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .fontWeight(.semibold)
                }
            } else if (id == 0) {
                Text(win.simpleDateString)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .fontWeight(.semibold)
            }
            WinCell(isTypeFeed: true, win: win)
                .overlay(
                    NavigationLink(destination: WinDetailView(win: win), label: {
                        EmptyView()
                    })
                    .opacity(0)
                )
                .onAppear() {
                    guard let lastWin = viewModel.typeWins.last else { return }
                    guard let lastIndex = viewModel.typeWins.lastIndex(of: lastWin) else { return }
                    if (lastIndex > 2) {
                        if (viewModel.typeWins[lastIndex - 2] == win) {
                            viewModel.fetchMoreTypeWins()
                        }
                    }
                }
                .listRowBackground(Color.clear)
            
        }
        .padding(.top, -30)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(typeString)")
        
    }
}

