//
//  SetupPageSecondView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI
import SwiftData

struct SetupPageGenderView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @State private var activeOption: Int = 0
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    var body: some View {
        VStack {
            Image("setup1")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
            
            TwoLineHeadingView(upperPart: "Please select", bottomPart: "your gender")
            
            VStack(spacing: 20) {
                GenderSelectRowView(gender: .Male, id: 0, activeOption: $activeOption)
                
                GenderSelectRowView(gender: .Female, id: 1, activeOption: $activeOption)
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            
            Button {
                user[0].userDetails?.setupActivePage += 1
                user[0].userDetails?.gender = activeOption == 0 ? .Male : .Female
                setupController.activePage += 1
                try? context.save()
            } label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            .padding(.top, 40)

        }
    }
}

#Preview {
    SetupPageGenderView()
        .environment(SetupController())
}
