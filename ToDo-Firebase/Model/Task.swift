//
//  Task.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Task: Identifiable, Decodable{
    @DocumentID var id: String?
    let text: String
    let timestamp: Timestamp
    let uid: String
    let priority: String
    let isComplete: Bool
}
