//
//  OpenEmailRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.09.23.
//

import SwiftUI

struct OpenEmailRowView: View {
    
    let image: String
    let label: String
    var imageSize: CGFloat = 37
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize)
                
                Text(label)
                    .foregroundStyle(.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                
                Image(systemName: "arrow.up.right.square.fill")
                    .foregroundStyle(.textGray)
                    .font(.title3)
            }
            .frame(height: 60)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    OpenEmailRowView(image: "appleMail", label: "Mail App") {
        print("Test")
    }
    .padding()
}
