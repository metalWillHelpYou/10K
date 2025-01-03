//
//  GoalViewModel.swift
//  10K
//
//  Created by metalWillHelpYou on 01.01.2025.
//

import Foundation

@MainActor
final class GoalViewModel: ObservableObject {
    @Published var savedGoals: [GoalEntity] = []
    @Published var goalTextHandler: String = ""
    
    func fetchGoals() {
        savedGoals = GoalCoreDataManager.shared.fetchGoals()
    }
    
    func addGoal(with title: String) {
        savedGoals = GoalCoreDataManager.shared.add(goal: title)
        fetchGoals()
        goalTextHandler = ""
    }
    
    func edit(_ goal: GoalEntity, with title: String) {
        savedGoals = GoalCoreDataManager.shared.edit(goal, newTitle: title)
        fetchGoals()
        goalTextHandler = ""
    }

    func delete(_ goal: GoalEntity) {
        savedGoals = GoalCoreDataManager.shared.delete(goal)
        fetchGoals()
    }
    
    func formatSeconds(_ seconds: Int) -> String {
        guard seconds != 36_000_000 else { return "10K" }
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
}
