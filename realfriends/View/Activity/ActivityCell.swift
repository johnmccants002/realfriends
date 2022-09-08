//
//  ActivityCell.swift
//  realfriends
//
//  Created by John McCants on 9/5/22.
//

import SwiftUI
import Kingfisher
import Firebase

struct ActivityCell: View {
    
    let activity: Activity
    var user: User?
    @ObservedObject var viewModel : ActivityCellViewModel
    
    
    init(activity: Activity) {
        self.activity = activity
        
        if let winId = activity.winId {
            self.viewModel = ActivityCellViewModel(id: winId, fromUid: nil)
        } else {
            self.viewModel = ActivityCellViewModel(id: nil, fromUid: activity.fromUid)
        }
        
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
            viewModel.win != nil ?
            
            AnyView(NavigationLink(
                destination: LazyView(WinDetailView(win: viewModel.win ?? Win(dict: ["":""])))
                
                
            , label: {
                Text(activity.winCaption ?? "")
                    .font(.system(size: 16, weight: .light))
            }))
            :
            AnyView(NavigationLink(
                destination: LazyView(UserProfileView(user: viewModel.user ?? User(dict: ["":""])))
            , label: {
                Text("View Profile")
            }))
            
        }
        
            
            
        
    }
}


