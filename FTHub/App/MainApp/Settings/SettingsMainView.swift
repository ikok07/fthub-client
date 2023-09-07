//
//  MoreMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI
import SwiftData

struct SettingsMainView: View {
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = true
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("hasDetails") private var hasDetails: Bool = true
    
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    @State private var appleHealth: Bool = false
    
    let imageUrl: URL? = URL(string: "")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SettingsMainProfileView(imageUrl: imageUrl, name: "John Smith", email: "kokmarok@gmail.com")
                
                SettingsGroupView(name: "Account Settings") {
                    VStack(alignment: .leading, spacing: 0) {
                        NavigationLink(destination: SettingsProfileDataView(imageUrl: imageUrl)) {
                            SettingsRowView(icon: "person", image: nil, label: "Profile Data")
                        }
                        SettingsRowView(icon: "star", image: nil, label: "Subscription")
                        SettingsRowView(icon: "key.horizontal", image: nil, label: "Change Password")
                        SettingsRowView(icon: "clock.arrow.2.circlepath", image: nil, label: "Workouts Synchronization")
                        SettingsRowView(icon: "bell", image: nil, label: "Notifications")
                        SettingsRowToggleView(icon: "heart", label: "Apple Health", isToggled: $appleHealth)
                    }
                }
                
                SettingsGroupView(name: "Information") {
                    VStack(alignment: .leading, spacing: 0) {
                        SettingsRowView(icon: nil, image: "instagram", label: "Profile Data")
                        SettingsRowView(icon: nil, image: "facebook", label: "Subscription")
                        SettingsRowView(icon: "person.2.badge.gearshape", image: nil, label: "Support & Feedback")
                        SettingsRowView(icon: "lock", image: nil, label: "Privacy Policy")
                    }
                }
                
                Button(action: {
                    withAnimation {
                        userLoggedIn = false
                        userToken = ""
                        hasDetails = false
                        if let user = user.first {
                            modelContext.delete(user)
                        }
                    }
                }, label: {
                    Text("Log Out")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.redGradient))
                .padding(.top)
                Spacer()
            }
            .navigationTitle("Discover more")
            .padding()
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SettingsMainView()
}
