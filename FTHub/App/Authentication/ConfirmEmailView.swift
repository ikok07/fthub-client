//
//  ConfirmEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct ConfirmEmailView: View {
    
    @State private var enteredNumbers: [String] = Array(repeating: "", count: 6)
    @State private var fullFields: Bool = false
    
    var body: some View {
        VStack {
            CodeInputHeaderView(title: "Email Confirmation", email: "youremail@email.com")
            
            CodeInputView(enteredNumbers: $enteredNumbers, fullFields: $fullFields)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeInputFooterView(fullFields: $fullFields)
        }
        .padding(.top, 10)
    }
}

#Preview {
    ConfirmEmailView()
}
