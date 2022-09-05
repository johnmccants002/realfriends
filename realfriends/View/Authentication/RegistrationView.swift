//
//  RegistrationView.swift
//  realfriends
//
//  Created by John McCants on 7/30/22.
//

import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    @State var username = ""
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var viewModel : AuthViewModel
    
    func loadImage() {
        guard let selectedUIImage = selectedUIImage else {
            return
        }
        image = Image(uiImage: selectedUIImage)
    }
    var body: some View {
        ZStack {
            VStack {
                Button(action: { showImagePicker.toggle() }, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()

                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(40)
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                                .foregroundColor(.white)
                        }
                    
                    }
                }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedUIImage)
                })
                
                if let image = image {
                    Text("Change Photo")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    
                } else {
                    Text("Add Photo")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
            
                
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        
                    
                    
                }
                
                .padding(.horizontal, 32)
                
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 8)
                            .padding(.trailing, 32)
                    })
                }
                Button(action: {
                    if let selectedUIImage = selectedUIImage {
                        viewModel.registerUser(email: email, password: password, username: username, fullname: fullname, profileImage: selectedUIImage)
                    }
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.purple)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                        
                        
                })
                Spacer()
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.bottom, 40)
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
        .background(Color(.systemPurple))
        .ignoresSafeArea()
  
       
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
