//
//  RestorePasswordCodeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordCodeView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    
    let email: String
    @State private var fullFields: Bool = false
    
    var body: some View {
        ScrollView {
            CodeAuthHeaderView(title: "Restore Password", email: "youremail@email.com")
                .padding(.top, 20)
            
            CodeAuthView(fullFields: $fullFields)
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeAuthFooterView(email: email, code: Int(numpadController.enteredNumber.joined()) ?? 0, type: .twofa, fullFields: $fullFields)
        }
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordCodeView(email: "kokmarok@gmail.com")
        .environmentObject(NumpadController())
}
