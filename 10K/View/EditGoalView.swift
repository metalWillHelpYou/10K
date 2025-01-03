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
            
            inputSection
            
            Spacer()
            
            doneButton
        }
        .padding()
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.goalTextHandler = goal.title ?? ""
        }
    }
}

extension EditGoalView {
    private var inputSection: some View {
        VStack(spacing: 16) {
            Text("Edit your goal")
                .font(.headline)
            
            TextField("New title goal", text: $viewModel.goalTextHandler)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .keyboardType(.default)
        }
        .foregroundStyle(.black)
    }
    
    private var doneButton: some View {
        Button("Done") {
            viewModel.edit(goal, with: viewModel.goalTextHandler)
            dismiss()
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

