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

    @State private var isAnimating = false
    @State private var isShowingPulse = false
    func startPulse(duration: Double) {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.isShowingPulse = true
            }
        }
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) {
                TodoListView(homeViewModel: homeViewModel)
                Button{
                    addNewTask.toggle()
                }label: {
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(Color.blue.opacity(isShowingPulse ? 0.1 : 0))
                            .frame(width: 92, height: 92)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                            .onAppear {
                                self.isAnimating = true
                                self.startPulse(duration: 0.3)
                            }
                        Circle()
                            .fill(Color.blue.opacity(isShowingPulse ? 0.3 : 0.1))
                            .frame(width: 86, height: 86)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                            .onAppear {
                                self.isAnimating = true
                                self.startPulse(duration: 0.3)
                            }
                        Circle()
                            .fill(Color.blue.opacity(isShowingPulse ? 0.5 : 0.2))
                            .frame(width: 74, height: 74)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                            .onAppear {
                                self.isAnimating = true
                                self.startPulse(duration: 0.3)
                            }
                        Image("plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                    }
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
            .navigationTitle("Tasks")
        }
    }
}
