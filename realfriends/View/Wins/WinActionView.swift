//
//  WinActionView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct WinActionView: View {
    let win: Win
    @ObservedObject var viewModel: WinActionViewModel
    
    init(win: Win) {
        self.win = win
        self.viewModel = WinActionViewModel(win: win)
    }
    var body: some View {
        HStack {
            Button(action: {
                viewModel.didRespect ? viewModel.unrespectWin() : viewModel.respectWin()
            }, label: {
                HStack {
                    Text("Respect")
                    Image(systemName: viewModel.didRespect ? "heart.fill": "heart")
                    
                }
                
            })
            .padding(.leading, 20)
            Spacer()
            Button(action: {}) {
                HStack {
                    Text("Reply")
                    Image(systemName: "message")
                }
                
            }
            .padding(.trailing, 20)
            
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
        
    }
}


