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
                CalculatorsFeaturedGroupView()
                
                AllCalculatorsGroupView()
            }
            .navigationTitle("Calculators")
        }
    }
}

#Preview {
    CalculatorsMainView()
}
