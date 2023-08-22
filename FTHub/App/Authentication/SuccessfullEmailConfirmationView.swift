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
            
            Text("Email verified")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    SuccessfullEmailConfirmationView()
}
