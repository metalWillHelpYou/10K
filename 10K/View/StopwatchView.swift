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
            
            Text(goal?.title ?? "Unknown")
                .font(.headline)
            
            Text(viewModel.formattedTime())
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.resetStopwatch()
                    dismiss()
                } label: {
                    Text("Reset")
                        .foregroundStyle(Color.white)
                        .padding()
                        .padding(.horizontal)
                        .frame(height: 55)
                        .strokeBackground(Color.red)
                }
                
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
        .padding()
        .foregroundStyle(Color.white)
        .background(Color.black)
        .onAppear {
            viewModel.startStopwatch()
        }
        .onDisappear {
            
        }
    }
}

#Preview {
    StopwatchView()
}
