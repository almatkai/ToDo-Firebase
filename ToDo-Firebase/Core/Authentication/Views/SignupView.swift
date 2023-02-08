//
//  SignupView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 07.01.2023.
//

import SwiftUI

struct SignupView: View {
    @State var email = ""
    @State var password = ""
    @State var passConfirm = ""
    @State var username = ""
    @State var fullname = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding
    
    @State private var nextButton = true
    
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
            
            NavigationLink(destination: ProfileSelectView(), isActive: $authViewModel.didAuthentificated, label: {})
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
            AuthHeaderView(title1: "Get started", title2: "Create your account")
                .padding(.bottom, 10)
            if nextButton {
                RegisterNameView(username: $username, fullname: $fullname, nextButton: $nextButton)
                    .modifier(TranstitionMoveModifier())
            }
            else{
                RegisterEmailView(email: $email, password: $password, passConfirm: $passConfirm, username: $username, fullname: $fullname, nextButton: $nextButton)
                    .modifier(TranstitionMoveModifier())
            }
            Spacer()
            HStack(alignment: .bottom){
                Spacer()
                Text("Already have an account?")
                    .font(.caption)
                NavigationLink{
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Sign in")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("forgroundSkyBlue"))
                }
                Spacer()
            }
            .frame(height: .infinity)
            .padding(.bottom, 14)
            
        }
        .background(Color("white"))
        .frame(height: .infinity)
        .edgesIgnoringSafeArea(.top)
//        .ignoresSafeArea()

    }
}

