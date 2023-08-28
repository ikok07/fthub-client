//
//  SetupPageThreeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI

struct SetupPageThreeView: View {
    
    @State private var offset: CGFloat = 0
    let pickerCount: Int = 10
    let startAge = 15
    
    func getAge() -> String {
        let startAge = startAge
        
        let progress = offset / 20
        
        return "\(startAge + (Int(progress)))"
    }
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "What is", bottomPart: "your age")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
            }
            
            VStack {
                VStack {
                    Text("years")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(getAge())
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                
                HorizontalPickerView(offset: $offset, minValue: startAge, maxValue: 65)
                
            }
            
            Button(action: {}, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
        }
        .padding()
    }
}

#Preview {
    SetupPageThreeView()
}
