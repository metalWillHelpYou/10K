//
//  TabView.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @State private var selectedGoal: GoalEntity?
    
    var body: some View {
        TabView {
            ForEach(0..<3, id: \.self) { index in
                GoalDetailView(goal: viewModel.savedGoals.indices.contains(index) ? viewModel.savedGoals[index] : nil)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .background(.ultraThinMaterial)
        .background(Image("1"))
    }
}

#Preview {
    RootView()
        .environmentObject(GoalViewModel())
}
