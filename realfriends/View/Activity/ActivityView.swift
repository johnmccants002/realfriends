//
//  ActivityView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var viewModel = ActivityViewModel()
    
    var body: some View {
        List(viewModel.activities) { activity in
            ActivityCell(activity: activity)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
            .navigationTitle("Activity")
    }
}
