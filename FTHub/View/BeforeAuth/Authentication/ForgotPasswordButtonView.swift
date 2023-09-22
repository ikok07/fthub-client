//
//  ForgotPasswordButtonView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.09.23.
//

import SwiftUI

struct ForgotPasswordButtonView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: RestorePasswordEmailView()) {
                Text("Forgot password?")
                    .foregroundStyle(.textGray)
                    .fontWeight(.medium)
                    .padding(.leading)
            }
            Spacer()
        }
    }
}

#Preview {
    ForgotPasswordButtonView()
}
