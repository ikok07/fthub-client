//
//  SetupPageOneView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI
import SwiftData

struct SetupPageOneView: View {
    
    @Environment(SetupController.self) private var setupController
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    var body: some View {
        VStack {
            Image("setup0")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
            
            VStack(spacing: 15) {
                TwoLineHeadingView(upperPart: "Let's setup", bottomPart: "your account")
                
                HeadlineView(text: "We need some data to make sure you have the best experience")
            }
            .padding(.horizontal)
            
            Button(action: {
                user[0].userDetails?.setupActivePage = 1
                setupController.activePage += 1
                DB.shared.saveContext()
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
}

#Preview {
    SetupPageOneView()
        .environment(SetupController())
}
