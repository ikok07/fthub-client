//
//  CustomTextFieldView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

enum TextFieldType: CaseIterable {
    case name, email, password, confirmPassword
}

struct CustomTextFieldView: View {
    @FocusState private var isFocused: Bool
    @AppStorage("currentPassword") var currentPassword: String = ""
    
    let icon: String
    let placeholder: LocalizedStringKey
    var autoCapitalize: Bool = true
    var secureField: Bool = false
    var disableAutoCorrect: Bool = false
    let type: TextFieldType?
    
    @Binding var text: String
    
    @State private var errorMessage: String? = nil
    
    private func validate(oldValue: String, newValue: String) {
        switch type {
        case .name:
            withAnimation {
                errorMessage = ValidationController.validateName(name: newValue).message
            }
            
            return
        case .email:
            withAnimation {
                errorMessage = ValidationController.validateEmail(email: newValue).message
            }
            
            return
        case .password:
            currentPassword = newValue

            withAnimation {
                errorMessage = ValidationController.validatePassword(password: newValue).message
            }
            
            return
        case .confirmPassword:
            
            if currentPassword != newValue {
                withAnimation {
                    errorMessage = "Passwords doesn't match!"
                }
            } else {
                withAnimation {
                    errorMessage = nil
                }
            }
            
            return
        case .none:
            return
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: icon)
                    .font(.title2)
                
                if !secureField {
                    TextField(placeholder, text: $text)
                        .font(.body)
                        .foregroundColor(.primary)
                        .textInputAutocapitalization(autoCapitalize ? .sentences : .never)
                        .autocorrectionDisabled(disableAutoCorrect)
                } else {
                    SecureField(placeholder, text: $text)
                        .font(.body)
                        .foregroundColor(.primary)
                        .textInputAutocapitalization(autoCapitalize ? .sentences : .never)
                }
                
                if errorMessage != nil {
                    Image(systemName: "exclamationmark.circle")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.textfieldError)
                        .scaleEffect(1.2)
                }
            }
            .padding()
            .background(.textfieldAppearance)
            .cornerRadius(12)
            .shadow(color: .textfieldBg.opacity(0.3), radius: 5, x: 0, y: 2)
            

            if errorMessage != nil {
                Text(errorMessage!)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.textfieldError)
                    .animation(.spring(), value: errorMessage)
                    .padding(.horizontal)
            }
        }
        .padding(.horizontal, 5)
        .onChange(of: text, validate)
    }
}

#Preview {
    CustomTextFieldView(icon: "envelope", placeholder: "Placeholder", type: .name, text: .constant(""))
        .padding()
}
