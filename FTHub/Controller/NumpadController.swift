//
//  NumpadController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import Foundation

class NumpadController: ObservableObject {
    @Published var enteredNumber: [String] = Array(repeating: "", count: 6)
    @Published var activeField: Int = 0
    
    func updateNumber(with newNumber: String) {
        if activeField < 6 {
            enteredNumber[activeField] = newNumber
            activeField += 1
        }
    }
    
    func deleteLastDigit() {
        if activeField > 0 {
            enteredNumber[activeField - 1] = ""
            activeField -= 1
        }
    }
    
    func setActiveField(on index: Int) {
        activeField = index
    }
    
}
