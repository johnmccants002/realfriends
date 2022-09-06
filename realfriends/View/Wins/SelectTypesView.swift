//
//  SelectTypesView.swift
//  realfriends
//
//  Created by John McCants on 9/6/22.
//

import SwiftUI

struct SelectTypesView: View {
    @ObservedObject var viewModel = SelectTypesViewModel()
    @ObservedObject var uploadViewModel: UploadWinViewModel
    @State var searchText = ""
    @State var showNewType = false
    @Binding var isShowingTypes : Bool
    
    init(uploadViewModel: UploadWinViewModel, isShowingTypes: Binding<Bool>) {
        self.uploadViewModel = uploadViewModel
        self._isShowingTypes = isShowingTypes
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("", text: $searchText, prompt: Text("Search or Add Type"))
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: searchText) { newValue in
                            let filteredTypes = viewModel.types.filter({$0.typeString == newValue})
                            
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
                .padding(.top, 10)
                
                List(viewModel.types) { type in
                    if searchText == "" {
                        Button {
                            uploadViewModel.typeString = type.typeString
                            isShowingTypes = false
                        } label: {
                            Text(type.typeString)
                        }

                        
                    } else if type.typeString.contains(searchText) {
                        Button {
                            uploadViewModel.typeString = type.typeString
                            isShowingTypes = false
                        } label: {
                            Text(type.typeString)
                        }
                    }
                }
                
                Spacer()
                
            }
        }
        .navigationTitle("Win Type")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color.purple, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
        
}

