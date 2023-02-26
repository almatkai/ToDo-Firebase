//
//  ToDoListView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

import SwiftUI
import Firebase

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TodoListView: View, Animatable {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var pendingTasks: [Task] {
        homeViewModel.tasks.filter { $0.isComplete == false }
    }
    
    var completedTasks: [Task] {
        homeViewModel.tasks.filter { $0.isComplete == true }
    }
    var body: some View {
        
        
        List {
            ForEach(Sections.allCases, id: \.self) { section in
                Section {
                    
                    let filteredTasks = section == .pending ? pendingTasks: completedTasks
                    
                    if filteredTasks.isEmpty {
                        Text("No tasks.")
                    }
                    ForEach(filteredTasks) { task in
                        TaskCellView(homeViewModel: homeViewModel, task: task)
                            
                    }.onDelete { indexSet in
                        
                        indexSet.forEach { index in
                            let task = filteredTasks[index]
                            homeViewModel.deletetask(documentId: task.id!)
                            
                            // delete all notes of a selected task
//                            for note in taskToDelete.notes {
//                                try? realm.write {
//                                    realm.delete(note)
//                                }
//                            }
                        }
                        
                    }
                } header: {
                    Text(section.rawValue)
                        .foregroundColor(section.rawValue == "Completed" ? .green : .gray)
                }

            }
        }
        .frame(alignment: .center)
        .transition(.slide)
        .animation(.easeOut(duration: 0.45))
    }
}
