//
//  TeasingTabView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct TeasingTabView: View {
    
    @Binding var selectedTab: Int
    let spacing: CGFloat
    let views: () -> [AnyView]
    
    @State private var offset = CGFloat.zero
    var viewCount: Int { views().count }

    var body: some View {
        
        VStack(spacing: spacing) {
            GeometryReader { geo in
                let width = geo.size.width * 0.88
                
                LazyHStack(spacing: spacing) {
                    Color.clear
                        .frame(width: geo.size.width * 0.15 - spacing)
                    ForEach(0..<viewCount, id: \.self) { idx in
                        views()[idx]
                            .frame(width: width)
                            .padding(.vertical)
                   }
                }
                .offset(x: CGFloat(-selectedTab) * (width + spacing) + offset - width * 0.11)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.width
                        }
                        .onEnded { value in
                            withAnimation(.easeOut) {
                                offset = value.predictedEndTranslation.width
                                selectedTab -= Int((offset / width).rounded())
                                selectedTab = max(0, min(selectedTab, viewCount-1))
                                offset = 0
                            }
                        }
                )
            }
            //
            HStack {
                ForEach(0..<viewCount, id: \.self) { idx in
                    Circle().frame(width: 8)
                        .foregroundStyle(idx == selectedTab ? .accent : .customGray)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                selectedTab = idx
                            }
                        }
                }
            }
        }
    }
}
