//
//  Constants.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import Foundation
import SwiftUI

struct K {
    
    // MARK: - Gradients
    struct Gradients {
        static let mainGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.accentColor, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
        static let secondaryGradient: LinearGradient = LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.27, green: 0.74, blue: 0.26).opacity(0.75), location: 0.00),
            Gradient.Stop(color: Color(red: 0.26, green: 0.74, blue: 0.64).opacity(0.75), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0, y: 0),
            endPoint: UnitPoint(x: 1.26, y: 1.69)
            )
        
        static let errorGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.customDarkRed]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        static let grayGradient: LinearGradient = LinearGradient(colors: [.textGray], startPoint: .leading, endPoint: .trailing)
        static let clearGradient: LinearGradient = LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .trailing)
    }

    
    
    // MARK: - API
    struct API {
        static let apiURL: String = "https://api.fthub.eu"
        static let apiV1: String = "v1"
        static let apiV2: String = "v2"
    }
    
    struct GridLayouts {
        static let standardColumnLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    }
    
}
