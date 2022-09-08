//
//  WinCell.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI
import Kingfisher

struct WinCell: View {
    let win: Win
    var percent: CGFloat = 0.7
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                KFImage(URL(string: win.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 32, height: 32)
                    .cornerRadius(32 / 2)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(win.fullname)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("@\(win.username)")
                            .foregroundColor(.gray)
                        
                        Text(win.timestampString)
                            .foregroundColor(.gray)
                            
                    }
                    Text(win.caption)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            }
            
            HStack {
                Spacer()
                Button(action: {}) {
                    cell("\(win.type) x\(win.typeCount)")
                }
                
            }
            
            WinActionView(win: win)
                .frame(maxWidth: .infinity)
                
        }
        .padding(.leading, -20)
    }
    
    @ViewBuilder

    func cell(_ string: String) -> some View {
        Text(string)
            .padding(.all, 5)
            .foregroundColor(Color.white)
            .font(.system(size: 12, weight: .semibold))
            .background(
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.purple)
                            .frame(width: geometry.size.width * 1.0, height: geometry.size.height)
                        Capsule()
                    }
                }
            )
            .clipShape(Capsule())
    }
}



