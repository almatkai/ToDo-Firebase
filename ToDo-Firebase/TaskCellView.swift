//
//  TaskCellView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 23.02.2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct TaskCellView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    let task: Task
    @State var offsetY : CGFloat = 0
    @State var isLinkActive = false
    var body: some View {
        
        VStack{
            HStack {
                Image(systemName: task.isComplete ? "checkmark.square": "square")
                    .frame(width: 20, height: 20)
                    .foregroundColor(task.isComplete ? .green : .gray)
                    .onTapGesture {
                        let isComplete = (task.isComplete) ? false : true
                        homeViewModel.updateTask(id: task.id!, fieldName: "isComplete", value: isComplete)
                    }
                Text(task.text)
                    .lineLimit(2)
                    .onTapGesture {
                        self.isLinkActive = true
                    }
                Spacer()
                    .onTapGesture {
                        self.isLinkActive = true
                    }
                Text(task.priority)
                    .padding(6)
                    .frame(width: 75)
                    .background(priorityBackground(task.priority))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .onTapGesture {
                        self.isLinkActive = true
                    }
            }.onTapGesture {
                self.isLinkActive = true
            }
            HStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(task.deadline, style: .time)
                        .font(.system(size:12))
                    Text(task.deadline, style: .date)
                        .font(.system(size:12))
                }
            }.onTapGesture {
                self.isLinkActive = true
            }
        }
        .onTapGesture {
            self.isLinkActive = true
        }
        .background(NavigationLink(destination: JustView(isLinkActive: $isLinkActive, homeViewModel: homeViewModel, task: task), isActive: $isLinkActive) {
            EmptyView()
        })
    }
}

