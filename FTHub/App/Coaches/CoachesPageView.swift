//
//  CoachesPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI
import SwiftData

struct CoachesPageView: View {
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = true
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("hasDetails") private var hasDetails: Bool = true
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var user: [User]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Logged into FTHub\npage: coaches")
                .multilineTextAlignment(.center)
            
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
                Text("Sign Out")
            })
        }
    }
}

#Preview {
    CoachesPageView()
}
