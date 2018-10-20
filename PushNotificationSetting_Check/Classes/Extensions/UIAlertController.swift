//
//  UIAlertController.swift
//  CheckNotificationSetting
//
//  Created by Yuuichi Watanabe on 2018/6/16.
//  Copyright © 2018年 Yuuichi Watanabe. All rights reserved.
//

import UIKit



extension UIAlertController {

    
    // MARK: - static
    static func showAlert(title: String? = nil, message: String, target: UIViewController? = nil, handler: (() -> Void)? = nil) {
     
        let alert = self.getDefultAlert(title: title, message: message, handler: handler)
        
        if let target = target {
            target.present(alert, animated: true, completion: nil)
        }
        else if let window = UIApplication.shared.keyWindow {
            var topViewController = window.rootViewController
            while (topViewController?.presentedViewController != nil) {
                topViewController = topViewController?.presentedViewController
            }
            if let mostTopViewController = topViewController {
                mostTopViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - static private
    static private func getDefultAlert(title: String? = nil, message: String, handler: (()->Void)?) -> UIAlertController {
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            if let handler = handler {
                handler()
            }
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(action)
        return alert
    }
}
