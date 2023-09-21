//
//  DbApplication.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.09.23.
//

import Foundation

struct DbApplication {
    
    static func initiate() async {
        await K.Database.getAppVariables()
    }
    
    static func getVariables() {
        
    }
    
}
