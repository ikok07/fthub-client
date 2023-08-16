//
//  ConfirmEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct ConfirmEmailView: View {
    
    let email: String
    @State private var code: Int = 0
    @State private var enteredNumbers: [String] = Array(repeating: "", count: 6)
    @State private var fullFields: Bool = false
    
    var body: some View {
        VStack {
            CodeAuthHeaderView(title: "Email Confirmation", email: "youremail@email.com")
            
            CodeAuthView(code: $code, enteredNumbers: $enteredNumbers, fullFields: $fullFields)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeAuthFooterView(email: email, code: code, fullFields: $fullFields)
        }
        .padding(.top, 10)
    }
}

#Preview {
    ConfirmEmailView(email: "kokmarok@gmail.com")
}
