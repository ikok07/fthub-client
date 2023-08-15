//
//  RestorePasswordCodeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordCodeView: View {
    
    @State private var inputValue: [String] = Array(repeating: "", count: 6)
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
            
            VStack(spacing: 20) {
                Text("Restore Password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                VStack {
                    Text("We have sent a code to")
                        .foregroundStyle(.textGray)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("youremail@email.com")
                        .tint(.text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } //: VStack
            } //: VStack
            
            CodeInputView(enteredPin: $inputValue)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            VStack {
                Button(action: {}, label: {
                    Text("Confirm")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle())
                .padding()
                
                HStack(spacing: 5) {
                    Text("Didn't receive code?")
                        .foregroundStyle(.gray)
                    Text("Resend now")
                        .foregroundStyle(K.mainGradient)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            } //: VStack
        }
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordCodeView()
}
