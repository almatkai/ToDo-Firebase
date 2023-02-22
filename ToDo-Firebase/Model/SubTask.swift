//
//  SubTask.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct SubTask: Identifiable, Decodable, Hashable{
    @DocumentID var id: String?
    var text: String
    let uid: String
    let timestamp: Timestamp
}
