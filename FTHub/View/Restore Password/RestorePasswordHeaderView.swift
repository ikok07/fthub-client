//
//  RestorePasswordHeaderVIew.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct RestorePasswordHeaderView: View {
    
    let headline: String
    
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
                    .multilineTextAlignment(.center)
                
                Text(headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    RestorePasswordHeaderView(headline: "Enter your account email to\nreset your password")
}
