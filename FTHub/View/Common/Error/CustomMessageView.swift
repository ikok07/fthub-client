//
//  ErrorMessageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import SwiftUI

struct CustomMessageView: View {
    
    let type: String
    
    @State private var icon: String? = nil
    @State private var color: Color? = nil
    let message: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon ?? "xmark")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.bg)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(width: 35)
                .background(color)
                .clipShape(Circle())
            
            Text(message)
                .foregroundStyle(Color(UIColor.label).opacity(0.5))
            Spacer()
        }
        .frame(minWidth: 300)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(color.opacity(0.15))
        .background(Color.bg)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            switch type {
            case "error":
                icon = "xmark"
                color = .customRed
            case "alert":
                icon = "exclamationmark"
                color = .customYellow
            case "success":
                icon = "checkmark"
                color = .customGreen
            case "info":
                icon = "exclamationmark"
                color = .customBlue
            default:
                icon = "xmark"
                color = .customRed
            }
        }
    }
}

#Preview {
    CustomMessageView(type: "info", message: "This is an error message This is an error message")
        .previewLayout(.sizeThatFits)
        .padding()
}
