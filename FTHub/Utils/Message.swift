//
//  Message.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI
import CoreData

struct Message {
    
    static func send(type: String, message: String) {
        
        let db = DB.shared
        let context = db.context
        let fetchRequest: NSFetchRequest<AppVariables> = AppVariables.fetchRequest()
        let fetchResult: Result<[AppVariables], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchResult {
        case .success(let variables):
            if !variables.isEmpty {
                if !variables[0].messagePresented {
                    DispatchQueue.main.async {
                        variables[0].messageType = type
                        variables[0].messageContent = message
                        withAnimation {
                            variables[0].messagePresented = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                variables[0].messagePresented = false
                            }
                        }
                    }
                }
            } else {
                print("There are no variables created when trying to send message")
                DbApplication.sendLog(description: "There are no variables created when trying to send message")
            }
        case .failure(let error):
            print("Could not get data from core data when trying to send message: \(error.localizedDescription)")
            DbApplication.sendLog(description: "Could not get data from core data when trying to send message: \(error.localizedDescription)")
        }
        
        
    }
    
}
