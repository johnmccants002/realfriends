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
            Text(win.caption)
                .font(.system(size: 22))
            
            Text(win.detailedTimestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Divider()
            
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
            
            WinActionView(win: win)
            
            Spacer()
            
        }.padding()}
    
}


