//
//  FeedView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct FeedView: View {
    @State var isShowingNewWin = false
    @ObservedObject var viewModel = FeedViewModel()
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(viewModel.wins.enumerated().map({$0}), id: \.1.self) { id, win in
                
                    if (id > 0) {
                        if (viewModel.wins[id - 1].simpleDateString != win.simpleDateString) {
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
                    WinCell(win: win)
                        .overlay(
                            NavigationLink(destination: WinDetailView(win: win), label: {
                                EmptyView()
                            })
                            .opacity(0)
                        )
                        .onAppear() {
                            guard let lastWin = viewModel.wins.last else { return }
                            guard let lastIndex = viewModel.wins.lastIndex(of: lastWin) else { return }
                            if (lastIndex > 2) {
                                if (viewModel.wins[lastIndex - 2] == win) {
                                    viewModel.fetchMoreLastWins()
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                }
            .padding(.top, -30)
            
            
            HStack {
                Spacer()
                Button(action: {isShowingNewWin.toggle() }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding()
                })
                .background(Color(.systemPurple))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .fullScreenCover(isPresented: $isShowingNewWin) {
                    NewWinView(isPresented: $isShowingNewWin, winText: "Testing", feedViewModel: viewModel)
                }
            }
        }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
