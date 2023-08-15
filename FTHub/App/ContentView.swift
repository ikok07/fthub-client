//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialMainView()
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: showTutorial)
    }
}

#Preview {
    ContentView()
}
