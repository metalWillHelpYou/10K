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
            
            Text("Add extra time")
                .font(.title3)
            Text("Only if you forgot about stopwatch")
                .font(.caption)
            
            
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
            
            Spacer()
            
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
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .strokeBackground(Color.black)
                    .padding(.bottom, 36)
            })
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity)
        .foregroundStyle(.black)
        .accentColor(.black)
    }
}

#Preview {
    AddTimeView(goal: nil)
}
