//
//  AutofillButtonView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI

struct AutofillButtonView: View {
    
    @Binding var autofill: Bool
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Text("Auto")
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 12))
            }
            .foregroundStyle(autofill ? .white : .black.opacity(0.3))
            .background {
                if autofill {
                    K.Gradients.mainGradient.opacity(0.75)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Material.regular)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .sensoryFeedback(.impact, trigger: autofill)
        }
    }
}

#Preview {
    AutofillButtonView(autofill: .constant(true)) {
        print("test")
    }
}
