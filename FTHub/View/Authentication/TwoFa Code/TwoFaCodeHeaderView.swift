//
//  CodeInputHeaderView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct TwoFaCodeHeaderView: View {
    
    let title: String
    let email: String
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
            
            VStack(spacing: 20) {
                Text(self.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                VStack {
                    Text("We have sent a code to")
                        .foregroundStyle(.textGray)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(self.email)
                        .tint(.text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                } //: VStack
            } //: VStack
        }
    }
}

#Preview {
    TwoFaCodeHeaderView(title: "Restore Password", email: "youremail@email.com")
}
