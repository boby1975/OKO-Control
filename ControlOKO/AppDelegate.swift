//
//  AppDelegate.swift
//  ControlOKO
//
//  Created by iMAC on 04.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit
//import PushKit
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print ("didFinishLaunchingWithOptions")
        
        Appearance.setGlobalAppearance()
        
        if let rootViewController = window?.rootViewController {
            rootViewController.storyboard?.configure(viewController: rootViewController)
        }

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //self.doBackgroundTask()
        
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print ("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print ("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*
     var backgroundUpdateTask: UIBackgroundTaskIdentifier!
     var count = 0
     var timer: Timer!
     
     func beginBackgroundUpdateTask() {
     self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
     self.endBackgroundUpdateTask_()
     })
     print ("beginBackgroundTask")
     }
     
     func endBackgroundUpdateTask_() {
     print ("TryBackgroundTask")
     
     
     /*
     if let backgroundUpdateTask_ = self.backgroundUpdateTask {
     UIApplication.shared.endBackgroundTask(backgroundUpdateTask_)
     self.backgroundUpdateTask = UIBackgroundTaskInvalid
     print ("restartBackgroundTask")
     
     self.doBackgroundTask()
     
     }
     */
     }
     
     func endBackgroundUpdateTask() {
     if let backgroundUpdateTask_ = self.backgroundUpdateTask {
     UIApplication.shared.endBackgroundTask(backgroundUpdateTask_)
     self.backgroundUpdateTask = UIBackgroundTaskInvalid
     print ("endBackgroundTask")
     
     //self.count = 0
     //self.timer.invalidate()
     //print ("timer invalidate")
     
     }
     }
     
     func doBackgroundTask() {
     self.beginBackgroundUpdateTask()
     DispatchQueue.global(qos: .background).async {
     
     
     // Do something with the result.
     self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(AppDelegate.displayAlert), userInfo: nil, repeats: true)
     RunLoop.current.add(self.timer, forMode: RunLoopMode.defaultRunLoopMode)
     RunLoop.current.run()
     
     while true {
     
     sleep (30)
     self.count += 1
     print ("do something: \(self.count)")
     AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
     
     }
     
     // End the background task.
     //self.endBackgroundUpdateTask()
     }
     }
     
     func checkSocket () {
     print ("checkSocket")
     }
     
     func displayAlert() {
     let note = UILocalNotification()
     //note.alertBody = "As a test I'm hoping this will run in the background every X number of seconds..."
     note.soundName = UILocalNotificationDefaultSoundName
     //UIApplication.shared.scheduleLocalNotification(note)
     count += 1
     print ("Background note: \(note)")
     }
     */
    
}

