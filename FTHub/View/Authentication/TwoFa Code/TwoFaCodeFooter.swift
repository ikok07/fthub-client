//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI
import SwiftData

struct TwoFaCodeFooter: View {
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var numpadController: NumpadController
    @EnvironmentObject var codeAuthController: TwoFaAuthController
    
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("buttonLoading") private var buttonLoading: Bool = false
    
    let email: String
    let code: Int
    
    var body: some View {
            VStack {
                Button(action: {
                    if numpadController.fullFields {
                        buttonLoading = true
                        
                        codeAuthController.email = self.email
                        codeAuthController.token = self.code
                        
                        codeAuthController.authenticateCode() { user in
                            if let user = user {
                                user.details = UserDetails(setupActivePage: 0)
                                modelContext.insert(user)
                            }
                        }
                    }
                }, label: {
                    
                    if buttonLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    } else {
                        Text("Confirm")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                      
                })
                .buttonStyle(CTAButtonStyle(gradient: {
                    if buttonLoading {
                        return K.Gradients.grayGradient
                    } else if numpadController.fullFields {
                        return K.Gradients.mainGradient
                    } else {
                        return K.Gradients.grayGradient
                    }
                }()))
                .animation(.easeOut(duration: 0.2), value: 10)
                .padding()
                
                TwoFaCodeResendButton() 
                .padding(.bottom, 30)
                
                CustomNumpadView()
            } //: VStack
            .onDisappear {
                numpadController.reset()
            }
    }
}

#Preview {
    TwoFaCodeFooter(email: "kokmarok@gmail.com", code: 123)
        .environmentObject(NumpadController())
        .environmentObject(TwoFaAuthController())
}
