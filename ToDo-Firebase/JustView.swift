//
//  JustView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

import SwiftUI
import Firebase


func priorityBackground(_ priority: String) -> Color {
    switch priority {
    case "low":
        return .gray
    case "medium":
        return Color(hex: "e6c244")
    case "high":
        return .red
    default:
        return .orange
    }
}

struct JustView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var isLinkActive: Bool
    
    @ObservedObject var homeViewModel: HomeViewModel
    var task: Task
    

    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "en_GB")
    ///
    @State var taskTitle = ""
    @State var deadline = Date()
    @State var priority = ""
    @State var subtask = ""
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter note", text: $taskTitle, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 20))
                    .padding()
                    .onAppear{
                        taskTitle = task.text
                    }
                    .onDisappear{
                        homeViewModel.updateAllFields(id: task.id!, text: taskTitle, priority: priority, deadline: deadline)
                    }
                Picker("Priority", selection: $priority) {
                    Text("low").tag("low").foregroundColor(.gray).font(.system(size:14)).fontWeight(.bold)
                    Text("medium").tag("medium").foregroundColor(.yellow).font(.system(size:14)).fontWeight(.bold)
                    Text("high").tag("high").foregroundColor(.red).font(.system(size:14)).fontWeight(.bold)
                    
                }.pickerStyle(.wheel)
                    .frame(width: 100, height: 120)
                    .foregroundColor(.green)
                    .font(.headline)
                    .onAppear{
                        priority = task.priority
                    }
            }
            HStack{
                DatePicker("", selection: $deadline)
                    .environment(\.locale, Self.locale)
                    .environment(\.calendar, Self.calendar)
                    .onAppear{
                        deadline = task.deadline
                    }
            }
            Divider()
            HStack{
                TextField("Enter subtask", text: $subtask, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(.left, 18)
                Button(action: {
                    appendSubtask(uid: task.id!, subtaskText: subtask)
                    subtask = ""
                }, label: {
                    Text("Add")
                }).buttonStyle(.borderedProminent)
                    .disabled(subtask.isEmpty)
            }.padding(15)
            Spacer()
            
            List {
                ForEach(task.sortedSubtask.indices, id: \.self) { index in
                    let note = task.sortedSubtask[index]
                    if(note != ""){
                        HStack {
                            Text("\(index + 1)")
                                .frame(width: 25, height: 25)
                                .background(randomColor())
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                            Text(note)
                        }.animation(.easeOut)
                    }
                }
                .onDelete{ indexSet in
                    guard let subtaskIndex = indexSet.first else { return }
                    homeViewModel.deleteSubtask(index: task.subtask.count - 1 - subtaskIndex, task: task)
                }
                .listStyle(.plain)
            }.listStyle(.plain)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.isLinkActive = false
                }, label: {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                        .lineLimit(1)
                })
            )
            .animation(.easeOut(duration: 0.25))
        }
    }
    func appendSubtask(uid: String, subtaskText: String){
        let db = Firestore.firestore()
        // Get the existing task object from Firestore
        db.collection("tasks").document(uid).getDocument { (document, error) in
            guard let document = document, document.exists, var task = try? document.data(as: Task.self) else {
                print("Task does not exist or failed to retrieve")
                return
            }
            // Append the new subtask to the task's subtasks array
            task.subtask.append(subtaskText)
            // Save the updated task object back to Firestore
            do {
                try db.collection("tasks").document(uid).setData(from: task)
                print("Subtask added successfully")
            } catch let error {
                print("Error adding subtask: \(error.localizedDescription)")
            }
        }
        
    }
}
