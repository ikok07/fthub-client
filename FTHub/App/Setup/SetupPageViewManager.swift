//
//  SetupPageViewManager.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageViewManager: View {
    
    @State private var activeSetupPage: Int = 0
    
    var body: some View {
        ZStack {
            switch activeSetupPage {
            case 0:
                SetupPageOneView(activeSetupPage: $activeSetupPage)
            case 1:
                SetupPageTwoView(activeSetupPage: $activeSetupPage)
            case 2:
                SetupPageThreeView()
            default:
                SetupPageOneView(activeSetupPage: $activeSetupPage)
            }
        }
        .animation(.easeOut, value: activeSetupPage)
    }
}

#Preview {
    SetupPageViewManager()
}
