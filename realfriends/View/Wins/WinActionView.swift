//
//  WinActionView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct WinActionView: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                HStack {
                    Text("Respect")
                    Image(systemName: "heart")
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

struct WinActionView_Previews: PreviewProvider {
    static var previews: some View {
        WinActionView()
    }
}
