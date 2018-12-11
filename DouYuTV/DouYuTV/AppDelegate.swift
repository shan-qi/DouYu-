//
//  AppDelegate.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/20.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SwiftTheme
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

