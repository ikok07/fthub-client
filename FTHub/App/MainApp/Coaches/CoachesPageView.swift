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
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var paywallPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Age: \(user[0].userDetails?.age ?? 0)")
            
            Text("\((user[0].userDetails?.gender ?? Gender.Male.rawValue))")
            
            Text("\(user[0].name ?? "")")
            
            Button(action: { paywallPresented = true }) {
                Text("Show paywall")
            }
        }
        .sheet(isPresented: $paywallPresented, content: {
            PaywallMainView(isPresented: $paywallPresented)
        })
    }
}

#Preview {
    CoachesPageView()
}
