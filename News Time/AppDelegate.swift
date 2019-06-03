//
//  AppDelegate.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/25/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Network
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    let monitor = NWPathMonitor()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        downloadNewsArticles()
        getSources()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                
            } else {
                self.dialogOKCancel()
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        return true
    }
    
    
    func downloadNewsArticles(){ 
        NewsService.instance.downloadNewsDetails {
            NotificationCenter.default.post(name: NOTIF_DOWNLOAD_COMPLETE, object: nil)
        }
    }
    func getSources()
    {
        NewsService.instance.downloadSourceDetails {
            NotificationCenter.default.post(name: NOTIF_DOWNLOAD_COMPLETE, object: nil)
        }
    }
    
    func dialogOKCancel(){
        let alertController = UIAlertController (title: "No Internet Connection", message: "Please turn on Mobile Data or connect to a Wi-Fi network.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Open Settings",
                                      style: UIAlertAction.Style.default,
                                      handler: openSettings))
        alertController.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)

    }
    
    func openSettings(alert: UIAlertAction!) {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
//    private func setUpSplashScreen(){
//        let launchScreenVC = UIStoryboard.init(name: "Main", bundle: nil)
//        let rootVC = launchScreenVC.instantiateViewController(withIdentifier: "launch")
//        self.window?.rootViewController = rootVC
//        self.window?.makeKeyAndVisible()
//        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissSelf), userInfo: nil, repeats: false)
//    }
//
//    @objc func dismissSelf(){
//        let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
//        let rootVC = mainVC.instantiateViewController(withIdentifier: "initialView")
//        self.window?.rootViewController = rootVC
//        self.window?.makeKeyAndVisible()
//    }

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

