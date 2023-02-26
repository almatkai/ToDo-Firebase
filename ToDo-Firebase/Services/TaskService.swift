//
//  TaskService.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import Firebase

struct TaskService{
    
    let db = Firestore.firestore()
    
    func uploadTasks(text: String, priority: String, deadline: Date, subtasks: [String], completion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let data = ["uid":uid, "text":text, "priority": priority, "isComplete":false, "deadline": deadline, "timestamp":Timestamp(date: Date()), "subtask":subtasks] as [String : Any]
        db.collection("tasks").document()
            .setData(data){error in
                if let error = error {
                    print("DEBUG: Failed to upload")
                    completion(false)
                }
                
                completion(true)
            }
    }
    
    func fetchTasks(forUid uid: String, completion: @escaping([Task]) -> Void) {
        db.collection("tasks")
            .whereField("uid", isEqualTo: uid)
            .getDocuments{snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let tasks = documents.compactMap({ try? $0.data(as: Task.self)})
            completion(tasks.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    
    func updateData(documentID: String, fieldName: String, value: Any) {
        db.collection("tasks").document(documentID)
            .updateData([fieldName: value]) { (error) in
                if let error = error {
                    print("Error updating data: \(error)")
                } else {
                    print("Data updated successfully")
                }
            }
    }
    func updateTask(_ task: Task) {
        guard let taskId = task.id else { return }
        let taskRef = db.collection("tasks").document(taskId)
        taskRef.updateData([
            "subtask": task.subtask
        ]) { error in
            if let error = error {
                print("Error updating subtask: \(error.localizedDescription)")
            } else {
                print("Subtask updated successfully.")
            }
        }
    }
    func updateMultipleFields(id: String, text: String, priority: String, deadline: Date) {
        let documentRef = db.collection("tasks").document(id)
        documentRef.updateData([
            "text": text,
            "priority": priority,
            "deadline": deadline
        ]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Document updated successfully")
            }
        }
    }
    func deleteTask(documentId: String){
        db.collection("tasks")
            .document(documentId)
            .delete { (error) in
                if let error = error {
                    print("Error removing document: \(error)")
                } else {
                    print("Document successfully removed!")
                }
            }
    }
    func deleteSubtask(_ index: Int, from task: Task) {
        guard let taskId = task.id else { return }
        var updatedTask = task
        updatedTask.subtask.remove(at: index)
        let taskRef = db.collection("tasks").document(taskId)
        taskRef.updateData([
            "subtask": updatedTask.subtask
        ]) { error in
            if let error = error {
                print("Error deleting subtask: \(error.localizedDescription)")
            } else {
                print("Subtask deleted successfully.")
                self.updateTask(updatedTask)
            }
        }
    }
}
