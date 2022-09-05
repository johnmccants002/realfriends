//
//  ProfileHeaderView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image("johncartoon")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(60)
                .shadow(color: .black, radius: 6, x: 0.0, y: 0.0)
            
            Text("John McCants")
                .font(.system(size: 16, weight: .semibold))
            Text("@johnswiftdev")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Web and iOS dev trying to build cool things and make a living.")
            
            HStack(spacing: 40) {
                VStack {
                    Text("15")
                        .font(.system(size: 16))
                        .bold()
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Text("15")
                        .font(.system(size: 16))
                        .bold()
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            Spacer()
            
        }
    
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
