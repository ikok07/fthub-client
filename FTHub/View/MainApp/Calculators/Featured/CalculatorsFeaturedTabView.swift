//
//  CalculatorsFeaturedTabView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorsFeaturedTabView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorsFeaturedBoxView(image: "featured1", name: "Calories", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: 0)
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .tag(0)
            CalculatorsFeaturedBoxView(image: "featured2", name: "Fats", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: -50)
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .tag(1)
            CalculatorsFeaturedBoxView(image: "featured3", name: "BMI", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: 0)
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .tag(2)
        }
        .tabViewStyle(.page)
        .frame(width: UIScreen.main.bounds.width * 0.95, height: 250)
        .animation(.linear(duration: 1000), value: selectedTab)
        .onAppear {
            changeTab()
        }
    }
    
    func changeTab() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if selectedTab < 2 {
                selectedTab += 1
            } else {
                selectedTab = 0
            }
        }
    }
    
}

#Preview {
    CalculatorsFeaturedTabView()
}
