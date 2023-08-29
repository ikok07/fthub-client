//
//  SetupPageViewManager.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageViewManager: View {
    
    @EnvironmentObject private var setupController: SetupController
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String?
    
    var body: some View {
        ZStack {
            switch setupController.activePage {
            case 0:
                SetupPageOneView()
            case 1:
                SetupPageTwoView()
            case 2:
                SetupPageThreeView()
            case 3:
                SetupPageFourView()
            default:
                Button(action: {
                    userLoggedIn = false
                    userToken = ""
                }, label: {
                    Text("Log Out")
                })
            }
        }
        .animation(.easeOut, value: setupController.activePage)
    }
}

#Preview {
    SetupPageViewManager()
        .environmentObject(SetupController())
}
