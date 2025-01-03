//
//  AddGoalView.swift
//  10K
//
//  Created by metalWillHelpYou on 01.01.2025.
//

import SwiftUI

struct AddGoalView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            inputSection
            
            Spacer()
            
            startButton
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

extension AddGoalView {
    private var inputSection: some View {
        VStack {
            Text("Your journey starts here")
                .font(.title3)
                .padding(.bottom, 8)
            
            TextField("What is your new goal?", text: $viewModel.goalTextHandler)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .keyboardType(.default)
        }
        .foregroundStyle(.black)
    }
    
    private var startButton: some View {
        Button("Let's go") {
            viewModel.addGoal(with: viewModel.goalTextHandler)
            dismiss()
        }
        .disabled(viewModel.goalTextHandler.isEmpty)
        .buttonStyle(PrimaryButtonStyle())
    }
}


#Preview {
    AddGoalView()
        .environmentObject(GoalViewModel())
}
