//
//  GoalCoreDataManager.swift
//  10K
//
//  Created by metalWillHelpYou on 03.01.2025.
//

import Foundation
import CoreData

final class GoalCoreDataManager {
    static var shared = GoalCoreDataManager()
    let container: NSPersistentContainer
    var savedGoals: [GoalEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container .loadPersistentStores { description, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
        savedGoals = fetchGoals()
    }
    
    func fetchGoals() -> [GoalEntity] {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        do {
            savedGoals = try container.viewContext.fetch(request)
        } catch  {
            print("Error: \(error)")
        }
        return savedGoals
    }
    
    func add(goal title: String) -> [GoalEntity] {
        let newGoal = GoalEntity(context: container.viewContext)
        
        newGoal.title = title
        newGoal.seconds = 36_000_000
        
        return saveData()
    }
    
    func edit(_ goal: GoalEntity, newTitle: String) -> [GoalEntity] {
        goal.title = newTitle
        savedGoals = saveData()
        return savedGoals
    }

    func delete(_ goal: GoalEntity) -> [GoalEntity] {
        container.viewContext.delete(goal)
        savedGoals = saveData()
        return savedGoals
    }
    
    func saveData() -> [GoalEntity] {
        do {
            try container.viewContext.save()
            savedGoals = fetchGoals()
        } catch {
            print("\(error.localizedDescription)")
        }
        return savedGoals
    }
}
