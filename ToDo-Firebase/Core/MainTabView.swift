//
//  MainTabView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 18.01.2023.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    @State private var index = 0
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        
        if let user = authViewModel.currentUser{
            TabView(selection: $index) {
                HomeView(user: user)
                    .onTapGesture {
                        self.index = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                ProfileView()
                    .onTapGesture {
                        self.index = 1
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(1)
            }.toolbar(){
                if let user = authViewModel.currentUser{
                    NavigationLink{
                        ProfileView()
                    }label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .frame(width: 36, height: 36, alignment: .center)
                            .cornerRadius(18)
                            .overlay(RoundedRectangle(cornerRadius: 18)
                                .stroke(Color(.systemBlue), lineWidth: 1), alignment: .center)
                    }
                }
            }.toolbar(index == 0 ? .visible : .hidden)
        }
    }
}
