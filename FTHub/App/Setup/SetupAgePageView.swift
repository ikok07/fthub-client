//
//  SetupPageThreeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI
import HorizontalNumberPicker

struct SetupAgePageView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State private var activeAge: Int = 15
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "What is", bottomPart: "your age")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
            }
            .padding()
            
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
        .environmentObject(SetupController())
}
