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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SettingsMainProfileView(imageUrl: URL(string: "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"), name: "John Smith", email: "kokmarok@gmail.com")
                
                SettingsGroupView(groupNumber: 1)
                
                SettingsGroupView(groupNumber: 2)
                
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
