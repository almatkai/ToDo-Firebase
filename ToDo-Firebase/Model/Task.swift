//
//  Task.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Task: Identifiable, Decodable, Encodable{
    @DocumentID var id: String?
    var text: String
    let timestamp: Timestamp
    let uid: String
    var priority: String
    var isComplete: Bool
    var deadline: Date
    var subtask: [String]
    
    var sortedSubtask: [String] {
        subtask.sorted(by: >)
    }
}

class TaskClass: Identifiable {
    var taskTitle = ""
    var priority = "medium"
    var deadline: Date = Date()
    var subtasks: [String] = []
    var subtask = ""
    var sortedSubtask: [String] {
        String(subtask.sorted(by: >)).split(separator: " ").map(String.init)
    }
}
