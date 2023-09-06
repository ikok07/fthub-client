//
//  SettingsMainProfileView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsMainProfileView: View {
    
    let imageUrl: URL?
    let name: String
    let email: String
    
    var body: some View {
        HStack(spacing: 20) {
            
            ProfileImageView(imageUrl: imageUrl, width: 60)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(email)
                    .tint(.textGray)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}

#Preview {
    SettingsMainProfileView(imageUrl: URL(string: ""), name: "John Smith", email: "youremail@email.com")
        .padding()
}
