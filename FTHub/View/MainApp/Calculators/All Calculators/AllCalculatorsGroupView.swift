//
//  AllCalculatorsGroup.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct AllCalculatorsGroupView: View {
    
    var body: some View {
        ScrollView {
            HStack {
                Text("All Calculators")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            
            AllCalculatorsListView()
        }
        .scrollIndicators(.hidden)
        .padding()
    }
}

#Preview {
    AllCalculatorsGroupView()
        .frame(height: 400)
}
