//
//  AuthViewModel.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 17.01.2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthentificated = false
    @Published var currentUser: User?
    private var tempUserSession:FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if let error = error {
                print("DEBUG: User failed to sign in with error \(error.localizedDescription)")
            }
            
            guard let user = result?.user else{return}
            self.userSession = user
            self.fetchUser()
            print("DEBUG: User succesfully logged in")
        }
    }
    
    func register(username: String, withEmail email: String, password: String, fullname: String){
    
        Auth.auth().createUser(withEmail: email, password: password){result, error in
            if let error = error{
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else{return}
//            self.userSession = user
            print("DEBUG: User has registered")
            print("DEBUG: User is \(self.userSession)")
            self.tempUserSession = user
            
            let data = ["email":email,
                        "username":username.lowercased(),
                        "fullname":fullname,
                        "uid":user.uid]
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) {_ in
                    self.didAuthentificated = true
                    self.fetchUser()
                }
            
        }
    }
    
    func logOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage){
        guard let uid = tempUserSession?.uid else{return}
        
        ImageUploader.uploadImage(image: image){profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]){ _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    func fetchUser(){
        guard let uid = self.userSession?.uid else{return}
        service.fetchUser(withUid: uid){user in
            self.currentUser = user
        }
    }
}
