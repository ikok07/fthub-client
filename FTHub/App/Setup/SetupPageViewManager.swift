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
    
    @EnvironmentObject private var healthKitController: HealthKitController
    
    var body: some View {
        ZStack {
            switch setupController.activePage {
            case 0:
                SetupPageOneView()
            case 1:
                SetupPageGenderView()
            case 2:
                SetupAgePageView()
            case 3:
                SetupPageHeightView()
            case 4 :
                SetupPageWeightView()
            case 5:
                SetupPageTrainingsPerWeekView()
            case 6:
                SetupPageGoalView()
            case 7:
                SetupPageHealthKitView()
            case 8:
                SetupPageNotificationsView()
            default:
                Button(action: {
                    userLoggedIn = false
                    userToken = ""
                    setupController.activePage = 0
                    print(setupController.age, setupController.height, setupController.weight, setupController.gender)
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
