//
//  SelectTypesView.swift
//  realfriends
//
//  Created by John McCants on 9/6/22.
//

import SwiftUI

struct SelectTypesView: View {
    @ObservedObject var viewModel = SelectTypesViewModel()
    @State var searchText = ""
    @State var showNewType = false
    
    
    func displayEmptyView() -> some View {
        return HStack {Button {
            print("empty")
        } label: {
            EmptyView()
        }
        }

    }
    
    func displayAddType() -> some View {
        return HStack {Button {
            viewModel.addNewUserType(typeString: searchText)
        } label: {
            Text("Add New Type")
        }
        }
    }
        
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $searchText, prompt: Text("Search or Add Type"))
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchText) { newValue in
                        let filteredTypes = viewModel.types.filter({$0.typeString.contains(searchText)})
                        
                        if searchText.isEmpty {
                            showNewType = false
                        } else if filteredTypes.isEmpty {
                            showNewType = true
                        } else {
                            showNewType = false
                        }
                    }
                
                showNewType ?
                AnyView(Image(systemName: "plus"))
                    .onTapGesture {
                        viewModel.addNewUserType(typeString: searchText)
                        searchText = ""
                    }
                :
                AnyView(EmptyView())
                    .onTapGesture {
                        print("do nothing")
                    }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
                            
            List(viewModel.types) { type in
                if searchText == "" {
                    Text(type.typeString)
                        
                } else if type.typeString.contains(searchText) {
                    Text(type.typeString)
                }
            }
  
            Spacer()
            
        }
    }
}

struct SelectTypesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTypesView()
    }
}
