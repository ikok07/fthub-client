//
//  SetupPageViewManager.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageViewManager: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    var body: some View {
        ZStack {
            switch setupController.activePage {
            case 0:
                SetupPageOneView()
            case 1:
                SetupPageTwoView()
            case 2:
                SetupPageThreeView()
            default:
                SetupPageOneView()
            }
        }
        .animation(.easeOut, value: setupController.activePage)
    }
}

#Preview {
    SetupPageViewManager()
        .environmentObject(SetupController())
}
