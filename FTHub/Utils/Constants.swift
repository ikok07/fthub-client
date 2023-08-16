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
    static let mainGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.accentColor, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let grayGradient: LinearGradient = LinearGradient(colors: [.textGray], startPoint: .leading, endPoint: .trailing)
    static let clearGradient: LinearGradient = LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .trailing)
    
    
    // MARK: - API
    static let apiURL: String = "https://api.fthub.eu"
    
}
