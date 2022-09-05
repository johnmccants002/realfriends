//
//  ActivityCell.swift
//  realfriends
//
//  Created by John McCants on 9/5/22.
//

import SwiftUI
import Kingfisher

struct ActivityCell: View {
    let activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
    }
    
    func getActivityCaption(type: String) -> some View {
        if type == "newRespect" {
            return (
                Text("\(activity.fullname) respects your win.")
                )
        } else {
            return (
                Text("\(activity.fullname) followed you.")
            )
        }
    }
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: activity.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 30, height: 30)
                    .cornerRadius(15)
                
                getActivityCaption(type: activity.type)
                Spacer()
                Text(activity.timestampString)
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .medium))
            }
            activity.winCaption != nil ?
            Text(activity.winCaption ?? "")
                .font(.system(size: 16, weight: .light))
            :
            Text("\(activity.fullname) followed you.")
        }
            
            
        
    }
}


