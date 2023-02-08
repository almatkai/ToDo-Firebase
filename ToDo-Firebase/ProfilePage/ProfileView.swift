//
//  ComingSoonView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 18.01.2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser{
            VStack{
                Spacer()
                HStack{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(50)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("skyBlue"), lineWidth: 3), alignment: .center)
                    VStack(alignment: .leading){
                        Text("Username: @\(user.username)")
                        Text("Fullname: \(user.fullname)")
                    }
                }
                Spacer()
                Spacer()
                Button{
                    authViewModel.logOut()
                } label: {
                    Text("Log out")
                }
                .modifier(ClassicButtonModifier(width: .long))
                .shadow(color: Color("shadowGray").opacity(0.7), radius: 7, x: 0, y: 0)
                .padding(.bottom, 20)
            }.transition(.slide)
                .animation(.easeOut(duration: 0.35))
        }
    }
}
