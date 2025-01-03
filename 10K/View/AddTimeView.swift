//
//  AddTimeView.swift
//  10K
//
//  Created by metalWillHelpYou on 03.01.2025.
//

import SwiftUI

struct AddTimeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    let goal: GoalEntity?
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            headerSection
            
            timePicker
            
            Spacer()
            
            addButton
        }
        .padding()
        .frame(maxHeight: .infinity)
        .foregroundStyle(.black)
    }
}

extension AddTimeView {
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Add extra time")
                .font(.title3)
            Text("Only if you forgot about stopwatch")
                .font(.caption)
        }
    }
    
    private var timePicker: some View {
        HStack(spacing: 20) {
            Picker("Hours", selection: $hours) {
                ForEach(0..<24) { hour in
                    Text("\(hour) h").tag(hour)
                        .foregroundStyle(Color.accentColor)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Minutes", selection: $minutes) {
                ForEach(0..<60) { minute in
                    Text("\(minute) m").tag(minute)
                        .foregroundStyle(Color.accentColor)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
    
    private var addButton: some View {
        Button(action: {
            if let goal = goal {
                GoalCoreDataManager.shared.timeSubtraction(
                    form: goal,
                    (hours * 3600) + (minutes * 60)
                )
                dismiss()
            }
        }, label: {
            Text("Add")
        })
        .buttonStyle(PrimaryButtonStyle())
    }
}


#Preview {
    AddTimeView(goal: nil)
}
