//
//  ProfileImageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI
import PhotosUI

struct ProfileImageView: View {
    
    let imageUrl: URL?
    let localImage: Image?
    let width: Double
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            if localImage != nil {
                localImage!
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Circle()
                        .foregroundStyle(.customGray.opacity(0.3))
                        .frame(width: width, height: width)
                    
                    Image(systemName: "person.fill")
                        .foregroundStyle(.textGray)
                        .font(.title)
                }
            }
        }
        .frame(width: width, height: width)
        .clipShape(Circle())
        .padding(.vertical, 25)
    }
}

#Preview {
    ProfileImageView(imageUrl: URL(string: ""), localImage: nil, width: 100)
}
