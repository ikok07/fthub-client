//
//  NotificationsController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import UserNotifications

struct NotificationsController {
    
    static func requestPermission(completion: @escaping ((Bool, Error?) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: completion)
    }
}
