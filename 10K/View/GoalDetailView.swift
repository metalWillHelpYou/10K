//
//  GoalDetailView.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import SwiftUI

struct GoalDetailView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @State private var showAddGoal: Bool = false
    @State private var showEditGoal: Bool = false
    @State private var showDeleteGoal: Bool = false
    @State private var showStopwatch: Bool = false
    @State private var showAddTime: Bool = false
    
    let goal: GoalEntity?
    
    var body: some View {
        VStack {
            if let goal = goal {
                toolbar
                
                Spacer()
                
                Text(goal.title ?? "No Title")
                    .font(.title)
                Text("\(viewModel.formatSeconds(Int(goal.seconds)))")
                    .font(.title2)
                
                Spacer()
                
                startButton
            } else {
                alternativeScreen
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundStyle(Color.black)
        .background(.clear)
        .sheet(isPresented: $showAddGoal, content: {
            AddGoalView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .background(.ultraThinMaterial)
                .background(Image("1"))
        })
        .sheet(isPresented: $showEditGoal, content: {
            if let goal = goal{
                EditGoalView(goal: goal)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .background(.ultraThinMaterial)
                    .background(Image("1"))
            }
        })
        .fullScreenCover(isPresented: $showStopwatch, content: {
            StopwatchView(goal: goal)
        })
        .sheet(isPresented: $showAddTime, content: {
            AddTimeView(goal: goal)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .background(.ultraThinMaterial)
                .background(Image("1"))
        })
        .confirmationDialog("Are you sure?", isPresented: $showDeleteGoal) {
            Button("Delete") {
                if let goal = goal {
                    viewModel.delete(goal)
                }
            }
        }
        .onAppear {
            viewModel.fetchGoals()
        }
        .onChange(of: showStopwatch) {
            viewModel.fetchGoals()
        }
        .onChange(of: showAddTime) {
            viewModel.fetchGoals()
        }
    }
}

extension GoalDetailView {
    private var toolbar: some View {
        HStack {
            Menu {
                Button(action: {
                    showEditGoal.toggle()
                }, label: {
                    Label(
                        title: { Text("Edit") },
                        icon: { Image(systemName: "pencil") }
                    )
                })
                
                Button(action: {
                    showDeleteGoal.toggle()
                }, label: {
                    Label(
                        title: { Text("Delete") },
                        icon: { Image(systemName: "trash") }
                    )
                })
                
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundStyle(Color.black)
                    .frame(width: 30, height: 30)
            }
            
            Spacer()
            
            Button(action: {
                showAddTime.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 20, height: 20)
            })
            .disabled(viewModel.savedGoals.count >= 3)
            
        }
        .foregroundStyle(Color.black)
    }
    
    private var startButton: some View {
        Button(action: {
            showStopwatch.toggle()
        }, label: {
            Text("Start")
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .strokeBackground(Color.black)
                .padding(.bottom, 36)
        })
    }
}

extension GoalDetailView {
    private var alternativeScreen: some View {
        VStack {
            HStack {
                EmptyView()
                
                Spacer()
                
                Button(action: {
                    showAddGoal.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                })
                .disabled(viewModel.savedGoals.count >= 3)
                .foregroundStyle(Color.black)
            }
            
            Spacer()
            
            Text("Place for new goal")
                .font(.title2)
            
            Spacer()
        }
    }
}
