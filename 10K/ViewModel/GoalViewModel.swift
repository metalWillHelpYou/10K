//
//  GoalViewModel.swift
//  10K
//
//  Created by metalWillHelpYou on 01.01.2025.
//

import Foundation
import CoreData

@MainActor
final class GoalViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedGoals: [GoalEntity] = []
    @Published var goalTextHandler: String = ""
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container .loadPersistentStores { description, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
        fetchGoals()
    }
    
    func fetchGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        do {
            savedGoals = try container.viewContext.fetch(request)
        } catch  {
            print("Error: \(error)")
        }
    }
    
    func addGoal() {
        let newGoal = GoalEntity(context: container.viewContext)
        
        newGoal.title = goalTextHandler
        newGoal.seconds = 36_000_000
        
        saveData()
        goalTextHandler = ""
    }
    
    func edit(_ goal: GoalEntity) {
        guard !goalTextHandler.isEmpty else { return }
        goal.title = goalTextHandler
        saveData()
        goalTextHandler = ""
    }

    func delete(_ goal: GoalEntity) {
        container.viewContext.delete(goal)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchGoals()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
