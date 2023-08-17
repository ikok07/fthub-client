//
//  ErrorMessageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import SwiftUI

enum CustomMessageType: CaseIterable {
    case error, alert, success, info
}

struct ErrorMessageView: View {
    
    let type: CustomMessageType
    
    @State private var icon: String? = nil
    @State private var color: Color? = nil
    let message: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "xmark")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(UIColor.background))
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color.customRed)
                .clipShape(Circle())
            
            Text(message)
                .foregroundStyle(Color(UIColor.label).opacity(0.5))
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color.customRed.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            switch type {
            case .error:
                icon = "xmark"
                color = .customRed
            case .alert:
                icon = "xmark"
                color = .customRed
            case .success:
                icon = "xmark"
                color = .customRed
            case .info:
                icon = "xmark"
                color = .customRed
            }
        }
    }
}

#Preview {
    ErrorMessageView(type: .error, message: "This is an error message This is an error message")
        .previewLayout(.sizeThatFits)
        .padding()
}
