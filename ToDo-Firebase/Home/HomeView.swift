//
//  HomeView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 18.01.2023.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @State private var addNewTask = false
    
    @ObservedObject var homeViewModel: HomeViewModel
    @State var currentDate = Date()

    init(user: User) {
        self.homeViewModel = HomeViewModel(user: user)
    }

    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) {
                TodoListView(homeViewModel: homeViewModel)
//                ScrollView{
//                    LazyVStack{
//                        ForEach(homeViewModel.tasks){task in
//                            VStack{
//                                Text(task.text)
//                            }
//                                .background(Color("skyBlue"))
//                                .padding(16)
//                                .onTapGesture {
//                                    if task.id != nil{
//                                        homeViewModel.deletetask(documentId: task.id ?? "No ID")
//                                    }
//                                }
//                        }
//                    }
//                }
                Button{
                    addNewTask.toggle()
                }label: {
                    Image("newTask")
                        .resizable()
                        .renderingMode(.template)
                        .background(Color("forgroundSkyBlue"))
                        .foregroundColor(Color("whitegrey"))
                        .scaledToFill()
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                .sheet(isPresented: $addNewTask){
                    CreateTaskView()
                }.padding(15)
                    .clipShape(Circle())
            }
            .onReceive(homeViewModel.$tasks){_ in
                homeViewModel.fetchTasks()
            }
            .toolbar(.visible)
            .transition(.slide)
            .animation(.easeOut(duration: 0.35))
            .navigationTitle("Tasks")
        }
    }
}
