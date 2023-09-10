//
//  CalculatorsMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorsMainView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
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
            .navigationTitle("Calculators")
        }
    }
}

#Preview {
    CalculatorsMainView()
}
