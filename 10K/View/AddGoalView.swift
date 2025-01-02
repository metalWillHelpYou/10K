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
            
            VStack {
                Text("Your journey start here")
                
                TextField("What is your new goal?", text: $viewModel.goalTextHandler)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.emailAddress)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.addGoal()
                dismiss()
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
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddGoalView()
        .environmentObject(GoalViewModel())
}
