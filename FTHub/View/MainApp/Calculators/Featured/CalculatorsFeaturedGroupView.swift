//
//  CalculatorsFeaturedGroup.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorsFeaturedGroupView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Featured")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            CalculatorsFeaturedTabView()
        }
    }
}

#Preview {
    CalculatorsFeaturedGroupView()
}
