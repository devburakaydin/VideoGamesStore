//
//  LocalPushNotificationManager.swift
//  VideoGamesStore
//
//  Created by Burak on 22.01.2023.
//

import Foundation
import UserNotifications
class LocalPushNotificationManager {
    
    static let shared = LocalPushNotificationManager()
    private init(){}
    
    
    func createPushNotification(){
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Hey"
        content.body = "Please come back"
        
        let date = Date().addingTimeInterval(5)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            print(error ?? "")
        }
    }
}
