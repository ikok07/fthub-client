//
//  OffsettableScrollView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI

struct OffsettableScrollView<T: View>: View {
    
    let axes: Axis.Set
    let showsIndicator: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: T
    
    init(axes: Axis.Set = .vertical, showsIndicator: Bool = true, offsetChanged: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content: () -> T) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            GeometryReader { geometry in
                Color.clear.preference(key: OffsetPrefferenceKey.self, value: geometry.frame(in: .named("ScrollView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "ScrollView")
        .onPreferenceChange(OffsetPrefferenceKey.self, perform: offsetChanged)
    }
}

private struct OffsetPrefferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}
