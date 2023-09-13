//
//  AutofillButtonView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI

struct AutofillButtonView: View {
    
    @Binding var autofill: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $autofill, label: {
                Text("Enable Autofill")
            })
            .sensoryFeedback(.impact, trigger: autofill)
        }
    }
}

#Preview {
    AutofillButtonView(autofill: .constant(true))
    .padding(.horizontal)
}
