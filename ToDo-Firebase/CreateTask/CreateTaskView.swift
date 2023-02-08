//
//  CreateTaskView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 29.01.2023.
//

import SwiftUI

enum Priority: String, CaseIterable {
    case low = "low"
    case medium = "medium"
    case high = "high"
}
class TaskClass: Identifiable {
    var title = ""
    var priority = Priority.medium
    var date: Date = Date.now
}

struct CreateTaskView: View {
    //Date Picker
    static let calendar = Calendar(identifier: .gregorian)
    static let locale = Locale(identifier: "en_GB")
    ///
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel = CreateTaskViewModel()
    ///
    @State var task = TaskClass()
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
                TextField("Enter note", text: $task.title, axis: .vertical)
                    .textFieldStyle(.plain)
                    .font(.system(size: 20))
                    .padding()
                Picker("Priority", selection: $task.priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                            .font(.system(size:14))
                            .foregroundColor(priorityBackground(priority.rawValue))
                    }
                    .fontWeight(.bold)
                    
                }.pickerStyle(.wheel)
                    .frame(width: 100, height: 120)
                    .foregroundColor(.green)
                    .font(.headline)
            }
            HStack{
                DatePicker("", selection: $task.date)
                    .environment(\.locale, Self.locale)
                    .environment(\.calendar, Self.calendar)
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                    taskViewModel.uploadTask(withText: task.title, priority: task.priority.rawValue)
                }, label: {
                    Text("Save task")
                }).buttonStyle(.borderedProminent)
            }

            Divider()
            HStack{
                TextField("Enter subtask", text: $subtask, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(.left, 18)
                Button(action: {
                }, label: {
                    Text("Add")
                }).buttonStyle(.borderedProminent)
                    .disabled(subtask.isEmpty)
            }
            //            ToFormsView()
            Spacer()
            
//            List {
//                ForEach(task.notes.indices, id: \.self) { index in
//                    let note = task.notes[index]
//                    HStack {
//                        Text("\(index + 1)")
//                            .frame(width: 25, height: 25)
//                            .background(.orange)
//                            .foregroundColor(.white
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
//                        Text(note.text)
//                    }
//                }
//                .onDelete(perform: $task.notes.remove)
//                .listStyle(.plain)
//            }.listStyle(.plain)
        }.padding()
            .onReceive(taskViewModel.$didUploadTask){succes in
                if succes {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
