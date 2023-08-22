//
//  SuccessfullEmailConfirmationView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct SuccessfullEmailConfirmationView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(K.Gradients.mainGradient)
                .padding(.bottom, 5)
            
            VStack(spacing: 15) {
                Text("Email verified")
                    .font(.title)
                    .fontWeight(.bold)
                Text("You have successfuly verified\n your email")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
            
            Button(action: {}, label: {
                Text("Go to Dashboard")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
    }
}

#Preview {
    SuccessfullEmailConfirmationView()
}
