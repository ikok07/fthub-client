//
//  SetupPageViewManager.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI
import SwiftData

struct SetupPageViewManager: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    @Environment(SetupController.self) private var setupController
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String?
    
    @Environment(HealthKitController.self) private var healthKitController
    
    var body: some View {
        ZStack {
            if let user = user.first {
                switch user.details?.setupActivePage {
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
                case 9:
                    SetupPageFinishView()
                default:
                    SetupPageOneView()
                }
            }
        }
        .animation(.easeOut, value: setupController.activePage)
    }
}

#Preview {
    SetupPageViewManager()
        .environment(SetupController())
        .environment(HealthKitController())
}
