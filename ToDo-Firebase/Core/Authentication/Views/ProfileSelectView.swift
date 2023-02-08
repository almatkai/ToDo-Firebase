//
//  ProfileSelectView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 22.01.2023.
//

import SwiftUI

struct ProfileSelectView: View {
    @State private var showImagePicker = false
    @State private var selectedImage:UIImage?
    @State private var image:Image?
    @Environment(\.presentationMode) var presentationMode: Binding
    @EnvironmentObject var authViewModel: AuthViewModel
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
        }
        }
    }
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Create your account", title2: "Add a profile photo")
            
            Button{
                showImagePicker.toggle()
            } label: {
                if let image = image{
                     image
                        .resizable()
                        .modifier(ProfileImageModifier())
                        .clipShape(Circle())
                        .overlay{
                            ZStack {
                                Text("Change")
                                    .font(.callout)
                                    .padding(6)
                                    .foregroundColor(.white)
                            }.background(Color.black)
                            .opacity(0.8)
                            .cornerRadius(10.0)
                            .padding(6)
                            .offset(y:60)
                        }
                }else {
                    Image("addProfilePic")
                        .resizable()
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                }
            }.padding(.top, 35)
                .sheet(isPresented: $showImagePicker, onDismiss: loadIamge){
                    ImagePicker(selectedImage: $selectedImage)
                }
                .shadow(color: Color("shadowGray").opacity(0.45), radius: 7, x: 0, y: 0)
            
            if let selectedImage = selectedImage{
                Button{
                    authViewModel.uploadProfileImage(selectedImage)
                } label: {
                    HStack{
                        Text("Continue")
                        Image(systemName: "chevron.right")
                    }.modifier(ClassicButtonModifier(width: .short))

                }.padding(.top, 15)
            } else {
                Button{
                    authViewModel.uploadProfileImage(Image("user").asUIImage())
                } label: {
                    
                    HStack{
                        Text("Skip")
                        Image(systemName: "chevron.right")
                    }.modifier(ClassicButtonModifier(width: .short))
                }.padding(.top, 15)
            }
            Spacer()
        }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            .background(Color("white"))
    }
    
    func loadIamge(){
        guard let selectedImage = selectedImage else {return}
        image = Image(uiImage: selectedImage)
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("forgroundSkyBlue"))
            .frame(width: 180, height: 180)
    }
}
