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
    func deletetask(documentId: String){
        service.deleteTask(documentId: documentId)
    }
}
