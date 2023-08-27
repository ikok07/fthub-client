//
//  SetupPageViewManager.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageViewManager: View {
    
    @AppStorage("activeSetupPage") private var activeSetupPage: Int = 0
    
    var body: some View {
        ZStack {
            switch activeSetupPage {
            case 0:
                SetupPageOneView()
            default:
                SetupPageOneView()
            }
        }
        .animation(.easeOut, value: activeSetupPage)
    }
}

#Preview {
    SetupPageViewManager()
}
