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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("You")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .bold))
                
                TextArea("What productive thing did you do today?", text: $winText)
                HStack {
                    Button {
                        print("Type button tapped")
                    }
                
                    label: {
                        Text("Basic")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: 100, maxHeight: 40)
                    .background(Color.teal)
                    .cornerRadius(10)
                    
                  
                    Spacer()
                    Spacer()

                }
                .padding(.leading, 20)
                Spacer()

            }
            .padding()
            .navigationBarItems(leading: Button(action: {isPresented.toggle()}, label: {
                Text("Cancel")
                    .foregroundColor(.white)
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
                    .foregroundColor(.white)
               
            }))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New Win")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.purple, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            Spacer()
        }

    }
}

