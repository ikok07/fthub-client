//
//  CoachesPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct CoachesPageView: View {
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = true
    @AppStorage("userToken") private var userToken: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Logged into FTHub\npage: coaches")
                .multilineTextAlignment(.center)
            
            Button(action: {
                withAnimation {
                    userLoggedIn = false
                    userToken = ""
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
