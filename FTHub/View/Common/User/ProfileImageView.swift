//
//  ProfileImageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI

struct ProfileImageView: View {
    
    let imageUrl: URL?
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .clipShape(Circle())
        } placeholder: {
            ZStack {
                Circle()
                    .foregroundStyle(.customGray.opacity(0.3))
                    .frame(width: 60)
                Image(systemName: "person.fill")
                    .foregroundStyle(.textGray)
                    .font(.title)
            }
        }
    }
}

#Preview {
    ProfileImageView(imageUrl: URL(string: "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
}
