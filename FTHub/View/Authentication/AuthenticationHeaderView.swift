//
//  AuthenticationHeaderView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    
    @Binding var activeOption: AuthOption
    
    var body: some View {
        VStack(spacing: 20) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
            
            VStack(spacing: 10) {
                Text("App Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
        } //: VStack
        
        LogRegButtonsView(activeOption: $activeOption)
            .padding(.bottom, 20)
    }
}

#Preview {
    AuthenticationHeaderView(activeOption: .constant(.signIn))
        .padding()
}
