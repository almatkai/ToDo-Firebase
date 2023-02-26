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
    
    @State var taskTitle = ""
    @State var priority = "medium"
    @State var deadline: Date = Date()
    @State var subtasks: [String] = []
    @State var subtask = ""

    var body: some View {
        VStack {
            HStack{
                if #available(iOS 16.0, *) {
                    TextField("Enter note", text: $taskTitle, axis: .vertical)
                        .textFieldStyle(.plain)
                        .font(.system(size: 20))
                        .padding()
                } else {
                    VStack {
                        Text("Enter note:")
                        TextField("", text: $taskTitle)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 20))
                            .padding(.vertical, 10)
                    }
                    .padding()
                }
                Picker("Priority", selection: $priority) {
                    Text("low").tag("low").foregroundColor(.gray).font(.system(size: 14, weight: .bold))
                    Text("medium").tag("medium").foregroundColor(.yellow).font(.system(size: 14, weight: .bold))
                    Text("high").tag("high").foregroundColor(.red).font(.system(size: 14, weight: .bold))
                    
                }.pickerStyle(.wheel)
                    .frame(width: 100, height: 120)
                    .foregroundColor(.green)
                    .font(.headline)
            }
            HStack{
                DatePicker("", selection: $deadline)
                    .environment(\.locale, Self.locale)
                    .environment(\.calendar, Self.calendar)
                Button(action: {
                    taskViewModel.uploadTask(withText: taskTitle, priority: priority, deadline: deadline, subtasks: subtasks)
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
            Spacer()
            
            List {
                ForEach(subtasks.sorted(by: >).indices, id: \.self) { index in
                    let note = subtasks.sorted(by: >)[index]
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
                .onDelete{ indexSet in
                    guard let subtaskIndex = indexSet.first else { return }
                    subtasks.remove(at: subtaskIndex)
                }
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

