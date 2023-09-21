//
//  SetupPageThreeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI
import HorizontalNumberPicker
import SwiftData

struct SetupAgePageView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var activeAge: Int = 15
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "What is", bottomPart: "your age")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
            }
            .padding()
            .padding(.top)
            
            VStack {
                VStack {
                    Text("years")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("\(activeAge)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                HorizontalPickerView(value: $activeAge, selectorGradient: K.Gradients.mainGradient, minValue: K.UserDetails.minAge, maxValue: K.UserDetails.maxAge, startValue: 18)
            }
            
            Button(action: {
                user[0].userDetails?.setupActivePage += 1
                user[0].userDetails?.age = Int16(activeAge)
                DB.shared.saveContext()
                setupController.age = self.activeAge
                setupController.activePage += 1
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    SetupAgePageView()
        .environment(SetupController())
}
