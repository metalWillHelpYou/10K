//
//  EditGoalView.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import SwiftUI

struct EditGoalView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @Environment(\.dismiss) var dismiss
    
    var goal: GoalEntity
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Edit your goal")
                    .font(.headline)
                
                TextField("New title goal", text: $viewModel.goalTextHandler)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.default)
                    .onAppear {
                        viewModel.goalTextHandler = goal.title ?? ""
                    }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.edit(goal)
                dismiss()
            }, label: {
                Text("Done")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .strokeBackground(Color.black)
                    .padding(.bottom, 36)
            })
            .disabled(viewModel.goalTextHandler.isEmpty)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
