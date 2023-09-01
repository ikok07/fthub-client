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
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound, .provisional], completionHandler: completion)
    }
}
