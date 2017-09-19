//
//  AppDelegate.swift
//  ScrollSmoothly
//
//  Created by ju on 2017/9/14.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // ----- For test
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        let _ = FPSDisplay.share
        // -----
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
    
}

