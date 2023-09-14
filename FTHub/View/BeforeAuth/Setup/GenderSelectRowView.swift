//
//  GenderSelectRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI
import SwiftData

enum Gender: String, CaseIterable, Codable {
    case Male, Female
}

struct GenderSelectRowView: View {
    
    @Environment(SetupController.self) private var setupController
    
    let gender: Gender
    let id: Int
    @Binding var activeOption: Int
    
    var body: some View {
        Button {
            activeOption = id
            setupController.gender = self.gender
        } label: {
            HStack {
                Image(activeOption == id ? gender.rawValue : "\(gender.rawValue)-gray")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                
                Text(gender == .Male ? "Male" : "Female")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(activeOption == id ? .white : .textGray)
                Spacer()
            }
            .padding(EdgeInsets(top: 13, leading: 10, bottom: 13, trailing: 10))
            .background(activeOption == id ? K.Gradients.mainGradient : K.Gradients.clearGradient)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(activeOption == id ? .clear : .textGray.opacity(0.5))
            }
        }

    }
}

#Preview {
    GenderSelectRowView(gender: .Female, id: 0, activeOption: .constant(0))
        .padding()
        .environment(SetupController())
}
