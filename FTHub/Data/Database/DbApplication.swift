//
//  DbApplication.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.09.23.
//

import Foundation

struct DbApplication {
    
    static func initiate() async {
        await K.Database.getAppVariables(completionHandlerWithoutEmptyCheck:  { variables, context in
            var showTutorial: Bool?
            if !variables.isEmpty {
                for variable in variables {
                    showTutorial = variable.showTutorial
                    context.delete(variable)
                }
            }
            let newVariables = AppVariables(context: context)
            newVariables.showTutorial = showTutorial ?? true
            context.insert(newVariables)
            DB.shared.saveContext()
        })
    }
    
}
