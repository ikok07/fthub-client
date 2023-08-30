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
//                SetupPageOneView()
//                SetupWeightPageView()
                GaugeView()
            case 1:
                SetupPageGenderView()
            case 2:
                SetupAgePageView()
            case 3:
                SetupHeightPageView()
            case 4 :
                SetupWeightPageView()
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
