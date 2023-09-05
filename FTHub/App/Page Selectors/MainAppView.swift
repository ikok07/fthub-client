//
//  MainAppView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

enum Tab: String, CaseIterable, Codable {
    case log, workout, coaches, calculators, more
}

struct MainAppView: View {
    
    @State private var activeTab: Tab = .coaches
    
    var body: some View {
        TabView(selection: $activeTab) {
            
            CoachesPageView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Logs")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
                .tag(Tab.log)
            
            CoachesPageView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Workout")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
                .tag(Tab.workout)

            
            CoachesPageView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Coaches")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
                .tag(Tab.coaches)

            
            CoachesPageView()
                .tabItem {
                    Image(systemName: "plusminus.circle.fill")
                    Text("Calculators")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
                .tag(Tab.calculators)

            
            SettingsMainView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
                .tag(Tab.more)

            
        }
    }
}

#Preview {
    MainAppView()
}
