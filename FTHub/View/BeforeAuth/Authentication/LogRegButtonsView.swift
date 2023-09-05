//
//  LogRegButtonsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

enum AuthOption: CaseIterable {
    case signIn
    case signUp
}

struct LogRegButtonsView: View {
    
    @Binding var activeOption: AuthOption
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    Button {
                        withAnimation(.linear(duration: 0.2)) {
                            activeOption = .signIn
                        }
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(activeOption == .signIn ? K.Gradients.mainGradient : K.Gradients.grayGradient)
                            .fontWeight(.bold)
                            .opacity(0.75)
                            .multilineTextAlignment(.center)
                    }

                }
                .frame(maxWidth: .infinity)
                .overlay {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: geometry.size.width / 2.3, height: 3)
                            .foregroundStyle(activeOption == .signIn ? K.Gradients.mainGradient : K.Gradients.clearGradient)
                            .padding(.top, 30)
                    }
                }
                
                Spacer()
                
                VStack {
                    Button {
                        withAnimation(.linear(duration: 0.2)) {
                            activeOption = .signUp
                        }
                    } label: {
                        Text("Sign Up")
                            .foregroundStyle(activeOption == .signUp ? K.Gradients.mainGradient : K.Gradients.grayGradient)
                            .fontWeight(.bold)
                            .opacity(0.75)
                            .multilineTextAlignment(.center)
                    }

                }
                .frame(maxWidth: .infinity)
                .overlay {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: geometry.size.width / 2.3, height: 3)
                            .foregroundStyle(activeOption == .signUp ? K.Gradients.mainGradient : K.Gradients.clearGradient)
                            .padding(.top, 30)
                    }
                }
                
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
        .frame(height: 60)
    }
}

#Preview {
    LogRegButtonsView(activeOption: .constant(.signUp))
}
