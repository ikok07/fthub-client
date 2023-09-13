//
//  ColorExtensions.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import Foundation
import SwiftUI

extension Color {
    static func arcColor(for classification: String) -> Color {
        switch classification {
        case "Severe Thinness":
            return .arc0
        case "Moderate Thinness":
            return .arc2
        case "Mild Thinness":
            return .arc3
        case "Normal":
            return .arc4
        case "Overweight":
            return .arc3
        case "Obese Class I":
            return .arc2
        case "Obese Class II":
            return .arc1
        case "Obese Class III":
            return .arc0
        default:
            return .arc0
        }
    }
}
