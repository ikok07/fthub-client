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
    
    var body: some View {
        ScrollView {
            CodeAuthHeaderView(title: "Restore Password", email: "youremail@email.com")
                .padding(.top, 20)
            
            CodeAuthView()
                .padding(.top, 30)
                .padding(.horizontal, 30)
            
            Spacer()
            
            CodeAuthFooterView(email: email, password: nil, code: Int(numpadController.enteredNumbers.joined()) ?? 0, type: .twofa)
        }
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordCodeView(email: "kokmarok@gmail.com")
        .environmentObject(NumpadController())
}
