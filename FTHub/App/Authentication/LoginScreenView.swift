//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct LoginScreenView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
                .padding(.bottom)
            VStack(spacing: 10) {
                Text("App Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    LoginScreenView()
}
