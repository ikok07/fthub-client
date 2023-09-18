//
//  test.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.09.23.
//

import SwiftUI

struct test: View {
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        ImagePickerUIKitView() {
            Text("test")
        }
    }
}

#Preview {
    test()
}
