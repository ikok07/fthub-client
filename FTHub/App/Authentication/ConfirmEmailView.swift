//
//  ConfirmEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

enum EmailAuthType: CaseIterable {
    case confirm, twofa
}

struct ConfirmEmailView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    
    let type: EmailAuthType
    let email: String
    
    var body: some View {
            VStack {
                CodeAuthHeaderView(title: "Email Confirmation", email: "youremail@email.com")
                
                CodeAuthView()
                    .padding(.top, 60)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                CodeAuthFooterView(email: email, code: Int(numpadController.enteredNumbers.joined()) ?? 0, type: .twofa)
            } //: HStack
            .padding(.top, 10)
    }
}

#Preview {
    ConfirmEmailView(type: .twofa, email: "kokmarok@gmail.com")
        .environmentObject(NumpadController())
}
