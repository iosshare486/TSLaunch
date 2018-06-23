//
//  AppDelegate.swift
//  TSLaunch
//
//  Created by 任鹏杰 on 2018/6/22.
//  Copyright © 2018年 任鹏杰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        
        let launch = TSLaunchContainerController()
        launch.config.setMainViewController(ViewController())
        launch.config.setLaunchImage(image: #imageLiteral(resourceName: "defaultAdvert"))
        launch.config.setIconImage(image: #imageLiteral(resourceName: "defaultLaunch"))
        launch.config.tapLaunchBlock = {
            
            let view = UIView.init()
            view.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
            view.backgroundColor = UIColor.green
            self.window?.addSubview(view)
        }
        
        self.window?.rootViewController = launch
        
        launch.config.setAdvertUrl(url: "https://ojhwnbiut.qnssl.com/Fupd28FbVoiYvEVZwwlfW5PWahX4")
        launch.config.setAdvertTime(time: 4)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

