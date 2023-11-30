//
//  Color.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//
import SwiftUI

extension Color {
    static let topColor1 = Color(hex: 0x309FA9)
    static let topColor2 = Color(hex: 0x195459)
    static let bottomColor1 = Color(hex: 0x3EB489)
    static let bottomColor2 = Color(hex: 0x2B8730)
    static let backgroundGradient = Gradient(colors: [bottomColor1, bottomColor2, topColor1, topColor2])
}

extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}
