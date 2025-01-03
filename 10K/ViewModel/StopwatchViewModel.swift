//
//  StopwatchViewModel.swift
//  10K
//
//  Created by metalWillHelpYou on 02.01.2025.
//

import Foundation
import Combine

@MainActor
final class StopwatchViewModel: ObservableObject {
    @Published var elapsedTime: Int = 0
    @Published var isStopwatchRunning: Bool = false
    
    private var stopwatchSubscription: AnyCancellable?
    private var pausedTime: Int = 0 
    
    // MARK: - Stopwatch Logic
    
    func startStopwatch() {
        guard !isStopwatchRunning else { return }
        if pausedTime == 0 {
            elapsedTime = 0
        }
        resumeStopwatch()
    }

    
    func pauseStopwatch() {
        stopwatchSubscription?.cancel()
        isStopwatchRunning = false
        pausedTime = elapsedTime
    }
    
    func resumeStopwatch() {
        guard !isStopwatchRunning else { return }
        
        stopwatchSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handleStopwatchTick()
            }
        isStopwatchRunning = true
    }
    
    func resetStopwatch() {
        stopwatchSubscription?.cancel()
        elapsedTime = 0
        pausedTime = 0
        isStopwatchRunning = false
    }
    
    private func handleStopwatchTick() {
        elapsedTime += 1
    }
    
    // MARK: - Time Formatting
    
    func formattedTime() -> String {
        let hours = elapsedTime / 3600
        let minutes = (elapsedTime % 3600) / 60
        let seconds = elapsedTime % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: - Cleanup
    
    deinit {
        stopwatchSubscription?.cancel()
    }
}
