//
//  ViewController.swift
//  CheckNotificationSetting
//
//  Created by Yuuichi Watanabe on 2018/6/16.
//  Copyright © 2018年 Yuuichi Watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isPushNotificatonEnabled: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Display only once.
        if !UIApplication.shared.isRegisteredForRemoteNotifications {
            PushNotificationService.shared.askNoticePermission()
        }
    }


    @IBAction func didTapTransitionToAppsettingButton(_ sender: Any) {
        PushNotificationService.shared.trinsitionToAppSetting()
    }

    @IBAction func didTapSuggestNoticePermissionButton(_ sender: Any) {
        self.transitionToAppSettingIfNeeded()
    }

    @IBAction func didTapAlreadyRegisteredAPN(_ sender: Any) {
        PushNotificationService.shared.alreadyRegisteredAPN { (isRegistrated) in
            print("is alreadyRegistered APN? ", isRegistrated)
        }
    }
}



// MARK: - private
extension ViewController {

    fileprivate func transitionToAppSettingIfNeeded() {
        let title   = "通知を有効にしよう"
        let message = "設定で通知設定を変更してください。"
        PushNotificationService.shared.getNoticePermissionState(handler: { (authorizationStatus) in
            if authorizationStatus == .denied {
                UIAlertController.showAlert(title: title, message: message, target: self, handler: {
                    PushNotificationService.shared.trinsitionToAppSetting()
                })
            }
        })
    }

}
