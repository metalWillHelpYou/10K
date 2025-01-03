//
//  GoalDetailView.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import SwiftUI

struct GoalDetailView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @State private var showAddGoal = false
    @State private var showEditGoal = false
    @State private var showDeleteGoal = false
    @State private var showStopwatch = false
    @State private var showAddTime = false
    
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
                
                Button("Start", action: { showStopwatch.toggle() })
                    .buttonStyle(PrimaryButtonStyle())
            } else {
                alternativeScreen
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundStyle(Color.black)
        .sheet(isPresented: $showAddGoal) {
            AddGoalView().sheetStyle()
        }
        .sheet(isPresented: $showEditGoal) {
            if let goal = goal {
                EditGoalView(goal: goal).sheetStyle()
            }
        }
        .sheet(isPresented: $showAddTime) {
            AddTimeView(goal: goal).sheetStyle()
        }
        .fullScreenCover(isPresented: $showStopwatch) {
            StopwatchView(goal: goal)
        }
        .confirmationDialog("Are you sure?", isPresented: $showDeleteGoal) {
            Button("Delete", role: .destructive) {
                if let goal = goal {
                    viewModel.delete(goal)
                }
            }
        }
        .onAppear { viewModel.fetchGoals() }
        .onChange(of: showStopwatch) { viewModel.fetchGoals() }
        .onChange(of: showAddTime) { viewModel.fetchGoals() }
    }
}

// MARK: - Subviews

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
                    .font(.title2)
            }
            
            Spacer()
            
            Button(action: {
                showAddTime.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .font(.title2)
            })
        }
        .foregroundStyle(Color.black)
    }
    
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
