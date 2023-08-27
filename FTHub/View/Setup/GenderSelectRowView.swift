//
//  GenderSelectRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI


enum Gender: String, CaseIterable {
    case male, female
}

struct GenderSelectRowView: View {
    
    let gender: Gender
    @State var active: Bool
    
    var body: some View {
        HStack {
            Image(active == true ? gender.rawValue : "\(gender.rawValue)-gray")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            Text(gender == .male ? "Male" : "Female")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(active == true ? .white : .textGray)
            Spacer()
        }
        .padding(EdgeInsets(top: 13, leading: 10, bottom: 13, trailing: 10))
        .background(active == true ? K.Gradients.secondaryGradient : K.Gradients.clearGradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(active == false ? .textGray : .clear)
        }
    }
}

#Preview {
    GenderSelectRowView(gender: .female, active: true)
        .padding()
}
