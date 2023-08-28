//
//  SetupPageThreeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI

struct SetupPageThreeView: View {
    
    @State private var age: Int = 18
    let pickerCount: Int = 10
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
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
                    Text("\(age)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        
                        ForEach(1...pickerCount, id: \.self) { index in
                        Rectangle()
                                .fill(.gray)
                                .frame(width: 1, height: 30)
                                .frame(width: 20)
                            
                            ForEach(1...4, id: \.self) { subIndex in
                                Rectangle()
                                        .fill(.gray)
                                        .frame(width: 1, height: 15)
                                        .frame(width: 20)
                            }
                        }
                    }
                    .offset(x: (getRect().width - 30) / 2)
                    .padding(.trailing, getRect().width - 30)
                }
                
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
