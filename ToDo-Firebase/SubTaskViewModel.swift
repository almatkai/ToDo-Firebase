//
//  SubTaskViewModel.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

import Foundation

class SubTaskViewModel: ObservableObject {
    @Published var tasks = [SubTask]()
    let uid: String
    init(uid: String){
        self.uid = uid
        self.fetchTasks(uid: uid)
    }
    let service = SubTaskService()
    func uploadTask(withText text: String, uid: String){
        service.uploadTasks(text: text, uid: uid)
    }
    func fetchTasks(uid: String){
        service.fetchTasks(forUid: uid){ tasks in
            self.tasks = tasks
        }
    }
    
}
