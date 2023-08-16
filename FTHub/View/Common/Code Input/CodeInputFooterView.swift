//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct CodeInputFooterView: View {
    
    @Binding var fullFields: Bool
    
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Text("Confirm")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: fullFields ? K.mainGradient : K.grayGradient))
            .animation(.easeOut(duration: 0.2), value: 10)
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
}

#Preview {
    CodeInputFooterView(fullFields: .constant(false))
}
