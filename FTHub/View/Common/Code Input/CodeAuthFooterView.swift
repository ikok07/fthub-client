//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct CodeAuthFooterView: View {
    
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    private let authController = AuthController()
    let email: String
    let code: Int
    
    @Binding var fullFields: Bool
    
    func performTwoFaAuthorization(response: TwoFaRequest) {
        print(response)
        if response.status == "success" {
            userToken = response.token
            userLoggedIn = true
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
                if fullFields {
                    Task {
                        let response = await authController.performTwoFa(email: email, code: code)
                        if let safeResponse = response {
                            performTwoFaAuthorization(response: safeResponse)
                        }
                    }
                }
            }, label: {
                    Text("Confirm")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: fullFields ? K.mainGradient : K.grayGradient))
            .animation(.easeOut(duration: 0.2), value: 10)
            .padding()
            
            HStack(spacing: 5) {
                Text("Didn't receive code?")
                    .foregroundStyle(.gray)
                Text("Resend now")
                    .foregroundStyle(K.mainGradient)
                    .fontWeight(.semibold)
            }
            .padding(.bottom)
        } //: VStack
    }
}

#Preview {
    CodeAuthFooterView(email: "kokmarok@gmail.com", code: 123, fullFields: .constant(false))
}
