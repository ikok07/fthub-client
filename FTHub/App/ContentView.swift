//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    private let showTutorial: Bool = true
    
    var body: some View {
        if self.showTutorial {
            TutorialMainView()
        }
    }
}

#Preview {
    ContentView()
}
