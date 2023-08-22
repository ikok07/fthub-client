//
//  ConfirmEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct TwoFaCodeView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    
    let email: String
    let password: String?
    
    var body: some View {
            VStack {
                TwoFaCodeHeaderView(title: "Email Confirmation", email: email)
                
                TwoFaCodeMainView()
                    .padding(.top, 60)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                TwoFaCodeFooter(email: email, code: Int(numpadController.enteredNumbers.joined()) ?? 0)
            } //: HStack
            .padding(.top, 10)
    }
}

#Preview {
    TwoFaCodeView(email: "kokmarok@gmail.com", password: nil)
        .environmentObject(NumpadController())
}
