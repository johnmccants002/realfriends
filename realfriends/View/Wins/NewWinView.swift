//
//  NewWinView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct NewWinView: View {
    @Binding var isPresented: Bool
    @State var winText: String = ""
    @ObservedObject var viewModel: UploadWinViewModel
    @ObservedObject var feedViewModel: FeedViewModel
    
    init(isPresented: Binding<Bool>, winText: String, feedViewModel: FeedViewModel) {
        self._isPresented = isPresented
        self.feedViewModel = feedViewModel
        self.viewModel = UploadWinViewModel(isPresented: isPresented)
    }
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                }
                
                TextArea("What productive thing did you do today?", text: $winText)
                Spacer()
            }
            .padding()
            .navigationBarItems(leading: Button(action: {isPresented.toggle()}, label: {
                Text("Cancel")
                    .foregroundColor(.blue)
            }), trailing: Button(action: {
                viewModel.uploadWin(caption: winText) { err in
                    self.feedViewModel.wins.removeAll()
                    self.feedViewModel.fetchWins()
                    
                    isPresented.toggle()
                }
                
            }, label: {
                Text("Post Win")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }))
            Spacer()
        }
    }
}

