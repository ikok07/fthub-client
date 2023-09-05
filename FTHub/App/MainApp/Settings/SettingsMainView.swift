//
//  MoreMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsMainView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                SettingsMainProfileView(imageUrl: URL(string: "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"), name: "John Smith", email: "kokmarok@gmail.com")
                
                SettingsGroupView()
                Spacer()
            }
            .navigationTitle("Discover more")
            .padding()
        }
    }
}

#Preview {
    SettingsMainView()
}
