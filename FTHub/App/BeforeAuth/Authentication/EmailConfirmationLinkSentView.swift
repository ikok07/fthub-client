//
//  RestorePasswordEmailSentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct EmailConfirmationLinkSentView: View {
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    
    @State private var openEmailViewActive: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Image("restore2")
                    .resizable()
                    .scaledToFit()
                    
                
                VStack {
                    Text("We have sent a link to")
                    Text(variables[0].userCurrentEmail ?? "")
                        .tint(.text)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            
            VStack(spacing: 20) {
                Button(action: {
                    openEmailViewActive = true
                }, label: {
                    Text("Open Mail")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                
                Button {
                    withAnimation {
                        variables[0].emailWithLinkSent = false
                        variables[0].showTokenVerifyStatus = false
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back to sign in")
                            .fontWeight(.semibold)
                    }
                }

            }
            .padding(.vertical, 50)
        }
        .padding()
        .sheet(isPresented: $openEmailViewActive, content: {
            OpenEmailOptionsView(isPresented: $openEmailViewActive)
                .presentationDetents([.height(325)])
        })
    }
}

#Preview {
    EmailConfirmationLinkSentView()
}
