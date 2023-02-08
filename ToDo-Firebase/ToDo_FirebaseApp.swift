//
//  ToDo_FirebaseApp.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 07.01.2023.
//

import SwiftUI
import FirebaseCore

@main
struct ToDo_FirebaseApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
          NavigationView {
              ContentView()
                  
          }.environmentObject(viewModel)
      }
    }
}
