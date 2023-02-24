//
//  CreateTaskView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 29.01.2023.
//

import SwiftUI

struct CreateTaskView: View {
    //Date Picker
    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "en_GB")
    ///
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel = CreateTaskViewModel()
    ///
    @State var task = TaskClass()
    
    @State var taskTitle = ""
    @State var subtasks: [String] = []
    @State var subtask = ""
    
    private func priorityBackground(_ priority: String) -> Color {
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
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter note", text: $taskTitle, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 20))
                    .padding()
                Picker("Priority", selection: $task.priority) {
                    Text("low").tag("low").foregroundColor(.gray).font(.system(size:14)).fontWeight(.bold)
                    Text("medium").tag("medium").foregroundColor(.yellow).font(.system(size:14)).fontWeight(.bold)
                    Text("high").tag("high").foregroundColor(.red).font(.system(size:14)).fontWeight(.bold)
                    
                }.pickerStyle(.wheel)
                    .frame(width: 100, height: 120)
                    .foregroundColor(.green)
                    .font(.headline)
            }
            HStack{
                DatePicker("", selection: $task.deadline)
                    .environment(\.locale, Self.locale)
                    .environment(\.calendar, Self.calendar)
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                    taskViewModel.uploadTask(withText: taskTitle, priority: task.priority, deadline: task.deadline, subtasks: subtasks)
                }, label: {
                    Text("Save task")
                }).buttonStyle(.borderedProminent)
                    .disabled(taskTitle.isEmpty)
            }

            Divider()
            HStack{
                TextField("Enter subtask", text: $subtask, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(.left, 18)
                Button(action: {
                    subtasks.append(subtask)
                    subtask = ""
                }, label: {
                    Text("Add")
                }).buttonStyle(.borderedProminent)
                    .disabled(subtask.isEmpty)
            }
            //            ToFormsView()
            Spacer()
            
            List {
                ForEach(subtasks.indices, id: \.self) { index in
                    let note = subtasks[index]
                    HStack {
                        Text("\(index + 1)")
                            .frame(width: 25, height: 25)
                            .background(.orange)
                            .foregroundColor(.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
                        Text(note)
                    }
                }
//                .onDelete(perform: $task.notes.remove)
                .listStyle(.plain)
            }.listStyle(.plain)
        }.padding()
            .onReceive(taskViewModel.$didUploadTask){succes in
                if succes {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

