//
//  StopwatchView.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import SwiftUI

struct StopwatchView: View {
    @StateObject private var viewModel = StopwatchViewModel()
    @Environment(\.dismiss) var dismiss
    var goal: GoalEntity?
    
    var body: some View {
        VStack {
            Spacer()
            
            goalTitle
            
            stopwatchTime
            
            Spacer()
            
            buttonSection
        }
        .padding()
        .foregroundStyle(Color.white)
        .background(Color.black)
        .onAppear {
            viewModel.startStopwatch()
        }
    }
}

extension StopwatchView {
    private var goalTitle: some View {
        Text(goal?.title ?? "Unknown")
            .font(.headline)
    }
    
    private var stopwatchTime: some View {
        Text(viewModel.formattedTime())
            .font(.largeTitle)
            .padding()
    }
    
    private var buttonSection: some View {
        HStack {
            resetButton
            
            toggleButton
        }
    }
    
    private var resetButton: some View {
        Button {
            if let goal = goal {
                GoalCoreDataManager.shared.timeSubtraction(form: goal, viewModel.elapsedTime)
                viewModel.resetStopwatch()
                dismiss()
            }
        } label: {
            Text("Reset")
                .foregroundStyle(Color.white)
                .padding()
                .padding(.horizontal)
                .frame(height: 55)
                .strokeBackground(Color.red)
        }
    }
    
    private var toggleButton: some View {
        Button(action: {
            viewModel.isStopwatchRunning ? viewModel.pauseStopwatch() : viewModel.startStopwatch()
        }) {
            Text(viewModel.isStopwatchRunning ? "Pause" : "Resume")
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal)
                .frame(height: 55)
                .strokeBackground(Color.white)
        }
    }
}

#Preview {
    StopwatchView()
}
