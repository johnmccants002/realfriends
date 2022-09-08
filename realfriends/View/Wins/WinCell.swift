//
//  WinCell.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI
import Kingfisher

struct WinCell: View {
    let isTypeFeed: Bool
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
                    .padding(.trailing, 5)

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
                        .padding(.bottom, 10)
                    
                    HStack {
                            isTypeFeed ?
                        AnyView(EmptyView())
                        :
                        AnyView(NavigationLink(
                            destination: LazyView(TypeFeedView(uid: win.uid, typeString: win.type, win: win))
                        , label: {
                            Button(action: {
                               print("Button tapped this is the win: \(win)")
                           }) {
                                cell("\(win.type) x\(win.typeCount)")
                            }
                        }))
                        
                    }
                }
            }
            
           
            
            WinActionView(win: win)
                .frame(maxWidth: .infinity)
                
        }

  
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



