//
//  TaskService.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import Firebase

struct TaskService{
    
    func uploadTasks(text: String, priority: String, completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        let data = ["uid":uid, "text":text, "priority": priority, "isComplete":false, "timestamp":Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tasks").document()
            .setData(data){error in
                if let error = error {
                    print("DEBUG: Failed to upload")
                    completion(false)
                }
                
                completion(true)
            }
    }
    
    func fetchTasks(forUid uid: String, completion: @escaping([Task]) -> Void) {
        Firestore.firestore().collection("tasks")
            .whereField("uid", isEqualTo: uid)
            .getDocuments{snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let tasks = documents.compactMap({ try? $0.data(as: Task.self)})
            completion(tasks.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    
    func deleteTask(documentId: String){
        Firestore.firestore().collection("tasks")
            .document(documentId)
            .delete { (error) in
                if let error = error {
                    print("Error removing document: \(error)")
                } else {
                    print("Document successfully removed!")
                }
            }
        
    }
}
