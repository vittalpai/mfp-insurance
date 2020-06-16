//
//  AppDelegate.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 07/01/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit
import IBMMobileFirstPlatformFoundation
import IBMMobileFirstPlatformFoundationPush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MFPPush.sharedInstance().initialize()
        UserLoginChallengeHandler()
        PinCodeChallengeHandler.registerSelf()
        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            //handle your notification
            print("Received Notification in didFinishLaunchingWithOptions \(userInfo)")

        }

        return true
    }
    
   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("Received Notification in didReceiveRemoteNotification \(userInfo)")

        // display the alert body
        if let notification = userInfo["aps"] as? NSDictionary,
            let alert = notification["alert"] as? NSDictionary,
            let body = alert["body"] as? String {
                showAlert(body)
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken: Registered device successfully")

        // Registers device token with server.
        MFPPush.sharedInstance().sendDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError: \(error.localizedDescription)")
        
        showAlert("Failed to register for remote notifications with error: \(error.localizedDescription)")
    }

    func showAlert(_ message: String) {
        let alertDialog = UIAlertController(title: "Push Notification", message: message, preferredStyle: UIAlertController.Style.alert)
        alertDialog.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))

        window!.rootViewController?.present(alertDialog, animated: true, completion: nil)
    }


}

