//
//  Extentions.swift
//  10K
//
//  Created by metalWillHelpYou on 01.01.2025.
//

import SwiftUI

extension View {
    func strokeBackground(_ color: Color) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(color, lineWidth: 2)
        )
    }
}

extension View {
    func sheetStyle() -> some View {
        self.presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .background(.ultraThinMaterial)
            .background(Image("1"))
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .strokeBackground(Color.black)
            .padding(.bottom, 36)
    }
}
