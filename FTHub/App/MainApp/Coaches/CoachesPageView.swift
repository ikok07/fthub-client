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
            Text("Age: \(user.first?.details?.age ?? 0)")
            
            Text("\((user.first?.details!.gender ?? .Male).rawValue)")
            
            Text("\(user.first?.name ?? "")")
            
            Button(action: {
                
            }, label: {
                Text("Sign Out")
            })
        }
    }
}

#Preview {
    CoachesPageView()
}
