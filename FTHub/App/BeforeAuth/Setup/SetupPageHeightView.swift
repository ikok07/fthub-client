//
//  SetupPageFourView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
// 

import SwiftUI
import SwiftData

struct SetupPageHeightView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var userHeight: Double?
    
    var body: some View {
        VStack {
            UnitSelectView()
            
            TwoLineHeadingView(upperPart: "Let's select", bottomPart: "your height")
            
            Spacer()
            
            VerticalNumberSelectorView(userHeight: $userHeight)
            
            Button(action: {
                user[0].userDetails?.setupActivePage += 1
                user[0].userDetails?.height = Double(userHeight ?? 170)
                setupController.activePage += 1
                try? context.save()
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
    SetupPageHeightView()
        .environment(SetupController())
}
