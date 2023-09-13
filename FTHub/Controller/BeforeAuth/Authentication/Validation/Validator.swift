//
//  DefaultExpression.swift
//  FTHub
//
//  Created by Martin on 22.08.23.
//

import Foundation

struct Validator {
    private static func matchesPattern(_ str: String, pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: str.utf16.count)
        return regex.firstMatch(in: str, options: [], range: range) != nil
    }
    
    static func isEmail(str: String) -> Bool {
        return matchesPattern(str, pattern: #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#)
    }
    
    static func containsLowercaseCharacter(str: String) -> Bool {
        return matchesPattern(str, pattern: ".*[a-z]+.*")
    }

    static func containsUppercaseCharacter(str: String) -> Bool {
        return matchesPattern(str, pattern: ".*[A-Z]+.*")
    }

    static func containsDigit(str: String) -> Bool {
        return matchesPattern(str, pattern: ".*\\d+.*")
    }

    static func containsSymbol(str: String) -> Bool {
        return matchesPattern(str, pattern: ".*[@#.!&]+.*")
    }
}
