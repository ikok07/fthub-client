//
//  NumpadController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import Foundation

class NumpadController: ObservableObject {
    @Published var enteredNumbers: [String] = Array(repeating: "", count: 6)
    @Published var activeField: Int = 0
    @Published var fullFields: Bool = false
    
    private func checkFullFields() {
        var count: Int = 0
        for number in enteredNumbers {
            if number.count > 0 {
                count += 1
            }
        }
        if count == 6 {
            fullFields = true
        } else {
            fullFields = false
        }
    }
    
    func updateNumber(with newNumber: String) {
        if activeField < 6 {
            enteredNumbers[activeField] = newNumber
            activeField += 1
        }
        checkFullFields()
    }
    
    func deleteLastDigit() {
        print(activeField)
        if activeField == 6 {
            enteredNumbers[activeField - 1] = ""
        } else if activeField > 0 {
            enteredNumbers[activeField] = ""
        }
        activeField -= 1
        checkFullFields()
    }
    
    func setActiveField(on index: Int) {
        activeField = index
    }
    
    func reset() {
        activeField = 0
        enteredNumbers = Array(repeating: "", count: 6)
    }
    
}
