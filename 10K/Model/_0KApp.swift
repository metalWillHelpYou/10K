//
//  _0KApp.swift
//  10K
//
//  Created by metalWillHelpYou on 01.01.2025.
//

import SwiftUI

@main
struct _0KApp: App {
    @StateObject var goalVm = GoalViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(goalVm)
        }
    }
}
