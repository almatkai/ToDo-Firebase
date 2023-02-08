//
//  RegisterEmailView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 22.01.2023.
//

import SwiftUI

struct RegisterEmailView: View {
    @Binding var email:String
    @Binding var password:String
    @Binding var passConfirm:String
    @Binding var username:String
    @Binding var fullname:String
    
    @Binding var nextButton:Bool
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var passMatch = true
    
    var body: some View {
        VStack(spacing: 40){
                AuthTextFieldView(imageName: "envelope", placeholder: "Email", text: $email)
                AuthTextFieldView(imageName: "lock", placeholder: "Password", text: $password, isSecureField: true)
                .onTapGesture {
                    passMatch = true
                }
                AuthTextFieldView(imageName: "exclamationmark.lock", placeholder: "Confirm password", text: $passConfirm, isSecureField: true)
        }
        .padding(.horizontal, 32)
        .padding(.top, 30)
        
        if(!passMatch){
            Text("Password don't match!")
                .foregroundColor(.red)
                .transition(.offset(y:-10))
                .animation(.easeOut(duration: 0.2))
        }else{HStack{}
                .frame(height: 20)
        }
        
        HStack{
            Spacer()
            Button{
                nextButton = true
            } label: {
                Text("Back")
                    .modifier(ClassicButtonModifier(width: .short))
            }
            .shadow(color: Color("shadowGray").opacity(0.7), radius: 7, x: 0, y: 0)
            Spacer()
            Button{
                if(password == passConfirm){
                    authViewModel.register(username: username, withEmail: email, password: password, fullname: fullname)
                }else{
                    passMatch = false
                    password = ""
                    passConfirm = ""
                }
            } label: {
                Text("Create account")
                    .modifier(ClassicButtonModifier(width: .short))
            }
            .shadow(color: Color("shadowGray").opacity(0.7), radius: 7, x: 0, y: 0)
            Spacer()
        }
    }
}
