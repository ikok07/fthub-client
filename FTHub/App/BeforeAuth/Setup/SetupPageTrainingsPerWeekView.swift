//
//  SetupPageTrainingsPerWeekView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI
import HorizontalNumberPicker
import SwiftData

struct SetupPageTrainingsPerWeekView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @State private var selectedDays: Int = 0
    
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            TwoLineHeadingView(upperPart: "How much", bottomPart: "do you train")
                .padding(.top)
            
            Image("setup2")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            
            VStack(spacing: 10) {
                VStack {
                    Text("days/week")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("\(selectedDays)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                
                HorizontalPickerView(value: $selectedDays, selectorGradient: K.Gradients.mainGradient, minValue: 2, maxValue: 7, startValue: 3)
            }
            
            Button(action: {
                if let user = user.first {
                    user.details?.setupActivePage += 1
                    user.details?.workoutsPerWeek = selectedDays
                }
                setupController.workoutsPerWeek = selectedDays
                setupController.activePage += 1
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    SetupPageTrainingsPerWeekView()
        .environment(SetupController())
}
