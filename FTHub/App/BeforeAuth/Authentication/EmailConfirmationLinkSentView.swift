//
//  RestorePasswordEmailSentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct EmailConfirmationLinkSentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    
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
                    UIApplication.shared.open(URL(string: "message://")!)
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
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                withAnimation(.easeOut) {
                    variables[0].emailWithLinkSent = false
                    variables[0].showTokenVerifyStatus = false
                }
            }
        }
    }
}

#Preview {
    EmailConfirmationLinkSentView()
}
