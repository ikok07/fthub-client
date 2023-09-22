//
//  MoreMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI
import SwiftData

struct SettingsMainView: View {
    
    @Environment(HealthKitController.self) private var healthKitController
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var appleHealth: Bool = false
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var imageUrl: URL?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                SettingsMainProfileView(imageUrl: imageUrl, name: name, email: email)
                    .padding()
                
                SettingsGroupView(name: "Account Settings") {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(destination: SettingsProfileDataView()) {
                            SettingsRowView(icon: "person", image: nil, label: "Profile Data")
                        }
                        NavigationLink(destination: SettingsSubscriptionView()) {
                            SettingsRowView(icon: "star", image: nil, label: "Subscription")
                        }
                        NavigationLink(destination: SettingsChangePasswordView()) {
                            SettingsRowView(icon: "key.horizontal", image: nil, label: "Change Password")
                        }
                        NavigationLink(destination: SettingsSyncWorkoutsView()) {
                            SettingsRowView(icon: "clock.arrow.2.circlepath", image: nil, label: "Sync Workouts")
                        }
                        NavigationLink(destination: SettingsNotificationsView()) {
                            SettingsRowView(icon: "bell", image: nil, label: "Notifications")
                        }
                    }
                }
                .padding()
                
                SettingsGroupView(name: "Information") {
                    VStack(alignment: .leading, spacing: 0) {
                        SettingsRowView(icon: nil, image: "instagram", label: "Profile Data")
                        SettingsRowView(icon: nil, image: "facebook", label: "Subscription")
                        SettingsRowView(icon: "person.2.badge.gearshape", image: nil, label: "Support & Feedback")
                        SettingsRowView(icon: "lock", image: nil, label: "Privacy Policy")
                    }
                }
                .padding()
                
                Button(action: {
                    Task {
                        await DbUserAuth.logOut()
                    }
                }, label: {
                    Text("Log Out")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.redGradient))
                .padding()
                .padding(.top)
                Spacer()
            }
            .navigationTitle("Discover more")
            .scrollIndicators(.hidden)
            .onAppear {
                if user.count != 0 {
                    self.name = user[0].name ?? "No name"
                    self.email = user[0].email ?? "No email"
                    self.imageUrl = URL(string: "https://storage.fthub.eu\(user[0].photo ?? "No ID")")
                }
            }
        }
    }
    
}

#Preview {
    SettingsMainView()
        .environment(HealthKitController())
}
