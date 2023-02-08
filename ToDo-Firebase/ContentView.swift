//
//  ContentView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 07.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        Group{
            if authViewModel.userSession == nil { //for now !=
                LoginView()
            }
            else if let user = authViewModel.currentUser {
                MainTabView()
            }
        }
    }
}
