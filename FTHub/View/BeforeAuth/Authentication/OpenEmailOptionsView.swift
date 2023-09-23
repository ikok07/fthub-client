//
//  OpenEmailOptionsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.09.23.
//

import SwiftUI

enum MailClient: String, CaseIterable, Codable {
    case mail, gmail, outlook
}

struct OpenEmailOptionsView: View {
    
    @Binding var isPresented: Bool
    
    func openClient(client: MailClient) {
        switch client {
        case .mail:
            UIApplication.shared.open(URL(string: "message://")!)
        case .gmail:
            UIApplication.shared.open(URL(string: "googlegmail://")!)
        case .outlook:
            UIApplication.shared.open(URL(string: "ms-outlook://")!)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                OpenEmailRowView(image: "appleMail", label: "Mail App", action: { openClient(client: .mail) })
                OpenEmailRowView(image: "gmail", label: "Gmail", action: { openClient(client: .gmail) })
                OpenEmailRowView(image: "outlook", label: "Outlook", imageSize: 35, action: { openClient(client: .outlook) })
            }
            .padding()
            .navigationTitle("Choose your client")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: { isPresented = false }, label: {
                    Text("Close")
                })
            }
        }
    }
}

#Preview {
    OpenEmailOptionsView(isPresented: .constant(true))
}
