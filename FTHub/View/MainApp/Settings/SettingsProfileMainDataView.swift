//
//  SettingsProfileMainDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import SwiftUI

struct SettingsProfileMainDataView: View {
    
    @Binding var name: String
    @Binding var email: String
    @Binding var gender: Gender
    @Binding var age: Int
    
    
    var body: some View {
        SettingsGroupView(name: "Main Data") {
            VStack(alignment: .leading, spacing: 0) {
                SettingsInputRowView(name: "Name") {
                    TextField("", text: $name)
                    .frame(width: 200)
                    .multilineTextAlignment(.trailing)
                }
                SettingsInputRowView(name: "Email") {
                    TextField("", text: $email)
                    .frame(width: 200)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .multilineTextAlignment(.trailing)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                SettingsInputRowView(name: "Gender") {
                    Picker("", selection: $gender) {
                        Text("Male")
                            .tag(Gender.Male)
                        Text("Female")
                            .tag(Gender.Female)
                    }
                    .tint(.text)
                }
                SettingsInputRowView(name: "Age") {
                    Picker("", selection: $age) {
                        ForEach(16...70, id: \.self) { i in
                            Text("\(i)")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                    .tint(.text)
                }
            }
        }
    }
}

#Preview {
    SettingsProfileMainDataView(name: .constant("John Smith"), email: .constant("testemail@email.com"), gender: .constant(.Male), age: .constant(18))
}
