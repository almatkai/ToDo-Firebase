//
//  HomeViewModel.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var tasks = [Task]()
    private let service = TaskService()
    let user: User
    
    init(user:User){
        self.user = user
        self.fetchTasks()
    }
    
    func fetchTasks(){
        guard let uid = user.id else { return }
        service.fetchTasks(forUid: uid){ tasks in
            self.tasks = tasks
        }
    }
    func updateTask(id: String, fieldName: String, value: Any){
        service.updateData(documentID: id, fieldName: fieldName, value: value)
    }
    func updateAllFields(id: String, text: String, priority: String, deadline: Date){
        service.updateMultipleFields(id: id, text: text, priority: priority, deadline: deadline)
    }
    func deletetask(documentId: String){
        service.deleteTask(documentId: documentId)
    }
}
