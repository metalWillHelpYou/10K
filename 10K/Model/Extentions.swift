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
