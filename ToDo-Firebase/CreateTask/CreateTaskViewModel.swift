//
//  CreateTaskViewModel.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 05.02.2023.
//

import Foundation

class CreateTaskViewModel: ObservableObject{
    @Published var didUploadTask = false
     
    let service = TaskService()
    func uploadTask(withText text: String, priority: String, deadline: Date, subtasks: [String]){
        service.uploadTasks(text: text, priority: priority, deadline: deadline, subtasks: subtasks){ succes in
            if succes{
                self.didUploadTask = true
            }else{
                //error
            }
        }
    }
}
