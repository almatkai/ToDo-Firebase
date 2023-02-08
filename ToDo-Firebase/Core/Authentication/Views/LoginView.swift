//
//  LoginView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 07.01.2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Hello", title2: "Welcome back")
                .padding(.bottom, 10)
        
            VStack(spacing: 36){
                
                AuthTextFieldView(imageName: "envelope", placeholder: "Email", text: $email)
                AuthTextFieldView(imageName: "lock", placeholder: "Password", text: $password, isSecureField: true)
    
            }
            .padding(.horizontal, 32)
            .padding(.top, 30)
            
            HStack{
                Spacer()
                
                NavigationLink{
                        Text("Navigation View...")
                }label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("forgroundSkyBlue"))
                        .padding()
                }
            }
            
            Button{
                authViewModel.login(withEmail: email, password: password) 
            } label: {
                Text("Log in")
                    .modifier(ClassicButtonModifier(width: .long))
            }
            .shadow(color: Color("shadowGray").opacity(0.7), radius: 7, x: 0, y: 0)
            
            Spacer()
            
            
            HStack(alignment: .bottom){
                Spacer()
                Text("Don't have an account?")
                    .font(.caption)
                NavigationLink{
                    SignupView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("forgroundSkyBlue"))
                }
                Spacer()
            }.frame(height: .infinity)
                .padding(.bottom, 14)
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color("white"))
    }
}
