//
//  CalculatorsFeaturedTabView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorsFeaturedTabView: View {
    
    @State private var selectedTab: Int = 0
    
    @State private var timer: Timer = Timer()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorsFeaturedBoxView(image: "featured1", name: "Calories", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: 0) { CaloriesCalculatorView() }
                .tag(0)
            CalculatorsFeaturedBoxView(image: "featured2", name: "Fats", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: -50) { EmptyView() }
                .tag(1)
            CalculatorsFeaturedBoxView(image: "featured3", name: "BMI", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: 0) { BMICalculatorView() }
                .tag(2)
        }
        .tabViewStyle(.page)
        .frame(width: UIScreen.main.bounds.width, height: 250)
        .animation(.linear(duration: 1000), value: selectedTab)
    }
    
}

#Preview {
    CalculatorsFeaturedTabView()
}
