//
//  SettingsGroupView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsGroupView: View {
    
    @State private var appleHealth: Bool = false
    
    let groupNumber: Int
    
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 6, height: 30)
                    .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                
                Text("Account Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.bottom)
            
            if groupNumber == 1 {
                SettingsFirstGroupRowsView(appleHealth: $appleHealth)
            } else if groupNumber == 2 {
                SettingsSecondGroupRowsView()
            }
            
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(lineWidth: 1)
                .foregroundStyle(.customGray)
        }
    }
}

#Preview {
    SettingsGroupView(groupNumber: 1)
        .padding()
}
