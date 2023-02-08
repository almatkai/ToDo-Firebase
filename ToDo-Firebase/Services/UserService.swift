//
//  UserService.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 22.01.2023.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

struct UserService{
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
}
