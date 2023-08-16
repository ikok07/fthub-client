//
//  RestorePasswordCodeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordCodeView: View {
    
    @State private var inputValue: [String] = Array(repeating: "", count: 6)
    @State private var fullFields: Bool = false
    
    var body: some View {
        ScrollView {
            CodeInputHeaderView(title: "Restore Password", email: "youremail@email.com")
                .padding(.top, 20)
            
            CodeInputView(enteredNumbers: $inputValue, fullFields: $fullFields)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeInputFooterView(fullFields: $fullFields)
        }
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordCodeView()
}
