//
//  AppDelegate.swift
//  Meetapp
//
//  Created by Azuan on 13/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        customNavigationAppearence()
        return true
    }
    
    private func customNavigationAppearence() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 21)!
        ]
    }
}

