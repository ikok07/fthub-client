//
//  AppleHealthIntegrateView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct AppleHealthIntegrateView: View {
    var body: some View {
        HStack(spacing: 25) {
            Image("apple-health")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.customGray)
                }
            
            Image(systemName: "plus")
                .foregroundStyle(.customGray)
                .font(.title)
                .fontWeight(.bold)
            
            Image("app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
        }
    }
}

#Preview {
    AppleHealthIntegrateView()
}
