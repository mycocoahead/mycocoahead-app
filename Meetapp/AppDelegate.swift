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
      
        let tabBarController = self.window!.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar as UITabBar
      
//        let tabBarItem1 = tabBar.items![0] as UITabBarItem
//        let tabBarItem2 = tabBar.items![1] as UITabBarItem
//        let tabBarItem3 = tabBar.items![2] as UITabBarItem
        let tabBarItem4 = tabBar.items![3] as UITabBarItem
      
//        tabBarItem1.selectedImage = UIImage(named: "FirstSelectedImage")
//        tabBarItem2.selectedImage = UIImage(named: "SecondSelectedImage")
//        tabBarItem3.selectedImage = UIImage(named: "ThirdSelectedImage")
        tabBarItem4.selectedImage = UIImage(named: "ico_star_selected")
      
        return true
    }
    
    private func customNavigationAppearence() {
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 21)!
        ]
    }
}

