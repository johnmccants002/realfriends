//
//  SelectTypesView.swift
//  realfriends
//
//  Created by John McCants on 9/6/22.
//

import SwiftUI

struct SelectTypesView: View {
    @ObservedObject var viewModel = SelectTypesViewModel()
    
    
    var body: some View {
        Text("Select types")
    }
}

struct SelectTypesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTypesView()
    }
}
