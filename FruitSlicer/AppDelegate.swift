//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShouldPause"), object: nil)
        let view = self.window?.rootViewController?.view as! SKView
        view.isPaused = true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        let view = self.window?.rootViewController?.view as! SKView
        view.isPaused = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShouldResume"), object: nil)
    }

}

