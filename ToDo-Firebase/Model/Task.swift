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
    var text: String
    let timestamp: Timestamp
    let uid: String
    var priority: String
    var isComplete: Bool
    var deadline: Date
}

class TaskClass: Identifiable {
    var title = ""
    var priority = "medium"
    var timestamp: Timestamp = Timestamp(date: Date())
    var deadline: Date = Date.now
}
