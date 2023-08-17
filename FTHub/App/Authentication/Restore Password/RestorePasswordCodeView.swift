//
//  RestorePasswordCodeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordCodeView: View {
    
    let email: String
    @State private var code: Int = 0
    @State private var inputValue: [String] = Array(repeating: "", count: 6)
    @State private var fullFields: Bool = false
    
    var body: some View {
        ScrollView {
            CodeAuthHeaderView(title: "Restore Password", email: "youremail@email.com")
                .padding(.top, 20)
            
            CodeAuthView(code: $code, enteredNumbers: $inputValue, fullFields: $fullFields)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeAuthFooterView(email: email, code: code, type: .twofa, fullFields: $fullFields)
        }
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordCodeView(email: "kokmarok@gmail.com")
}
