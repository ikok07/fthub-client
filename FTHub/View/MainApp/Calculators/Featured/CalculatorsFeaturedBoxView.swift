//
//  CalculatorsFeaturedBoxView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorsFeaturedBoxView: View {
    
    let image: String
    let name: String
    let description: String
    
    let offsetX: Double?
    let offsetY: Double?
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .offset(x: offsetX ?? 0, y: offsetY ?? 0)
            .frame(width: UIScreen.main.bounds.width * 0.95, height: 250)
            .overlay {
                Rectangle()
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                            Gradient.Stop(color: .black.opacity(0), location: 0.00),
                            Gradient.Stop(color: .black.opacity(0.9), location: 0.8),
                            ],
                            startPoint: UnitPoint(x: 1, y: 0),
                            endPoint: UnitPoint(x: 0, y: 1)
                        )
                    )
                
                HStack {
                    VStack {
                        Spacer()
                        HStack {
                            Text(name)
                                .foregroundStyle(.white)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text(description)
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        HStack {
                            Button(action: {}, label: {
                                Text("Check out")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 9, leading: 5, bottom: 9, trailing: 5))
                            })
                            .frame(minWidth: 0, maxWidth: 100)
                            .foregroundStyle(.text)
                            .fontWeight(.bold)
                            .background(.background)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                    }
                    
                }
                .padding()
                .padding(.bottom, 10)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CalculatorsFeaturedBoxView(image: "featured2", name: "Calories", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd", offsetX: 0, offsetY: -50)
        .padding()
}
