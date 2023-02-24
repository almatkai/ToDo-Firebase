//
//  SubTaskService.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

//import Firebase
//
//struct SubTaskService{
//    func uploadTasks(text: String, uid: String){
//        let data = ["uid":uid, "text":text, "timestamp":Timestamp(date: Date())] as [String : Any]
//        
//        Firestore.firestore().collection("subtasks").document()
//            .setData(data)
//    }
//    func fetchTasks(forUid uid: String, completion: @escaping([SubTask]) -> Void) {
//        Firestore.firestore().collection("tasks")
//            .whereField("uid", isEqualTo: uid)
//            .getDocuments{snapshot, _ in
//            guard let documents = snapshot?.documents else {return}
//            let tasks = documents.compactMap({ try? $0.data(as: SubTask.self)})
////            completion(tasks.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
//            }
//    }
//    
//}
