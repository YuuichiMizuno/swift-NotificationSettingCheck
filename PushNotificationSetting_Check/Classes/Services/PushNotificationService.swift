//
//  PushNotificationService.swift
//  CheckNotificationSetting
//
//  Created by Yuuichi Watanabe on 2018/6/16.
//  Copyright © 2018年 Yuuichi Watanabe. All rights reserved.
//

import UIKit
import UserNotifications



class PushNotificationService: NSObject {

    static let shared = PushNotificationService()
    

    func askNoticePermission() {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                    guard error == nil else { return }
                    if granted {
                        print("allowed push notification.")
                        center.delegate = self as UNUserNotificationCenterDelegate
                    } else {
                        print("denied push notification.")
                    }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    
    func trinsitionToAppSetting() {
        
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /// caution!:   Note the difference between permission and registered.
    ///             It is hard to check in development environment.
    func alreadyRegisteredAPN(handler: @escaping((Bool) -> ())) {
        DispatchQueue.main.async {
            handler(UIApplication.shared.isRegisteredForRemoteNotifications)
        }
    }
    
    func getNoticePermissionState(handler: @escaping((UNAuthorizationStatus) -> ()) ) {

        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            //switch settings.authorizationStatus {               // for check
            //case .authorized:    print("Allow notification")
            //case .denied:        print("Denied notification")
            //case .notDetermined: print("Not settings")
            //}
            
            handler(settings.authorizationStatus)
        }
    }
    
}



extension PushNotificationService: UNUserNotificationCenterDelegate {
    
    //func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //    print(response)
    //}
    
    //func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //    print(notification)
    //}

}
