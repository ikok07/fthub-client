//
//  RestorePasswordMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI
import SwiftData

struct RestorePasswordMainView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("showRestorePassword") private var showRestorePassword: Bool = false
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            RestorePasswordHeaderView(headline: "Enter your email\n to reset your password")
            
            VStack(spacing: 20) {
                CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter new password", autoCapitalize: false, secureField: true, type: .password, text: $password)
                
                CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm new password", autoCapitalize: false, secureField: true, type: .confirmPassword, text: $confirmPassword)
            }
            .padding(.vertical, 50)
            
            Button(action: {
                Task {
                    loadingPresented = true
                    await RestorePasswordController.changePassword(password: self.password, confirmPassword: self.confirmPassword) { newUser in
                        Task {
                            let details = await AccountController.checkDetails()
                            if let userDetails = details, let safeUser = newUser {
                                if let user = user.first {
                                    modelContext.delete(user)
                                }
                                newUser?.details = userDetails
                                modelContext.insert(safeUser)
                            }
                        }
                    }
                }
            }, label: {
                Text("Create new password")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            Spacer()
        }
        .padding()
        .padding(.top, 10)
        .onChange(of: scenePhase) { oldValue, newValue in
            if scenePhase == .background {
                showRestorePassword = false
            }
        }
    }
}

#Preview {
    RestorePasswordMainView()
}
