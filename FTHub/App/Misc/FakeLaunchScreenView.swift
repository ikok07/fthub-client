//
//  FakeLaunchScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import SwiftUI

struct FakeLaunchScreenView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 135)
    }
}

#Preview {
    FakeLaunchScreenView()
}
