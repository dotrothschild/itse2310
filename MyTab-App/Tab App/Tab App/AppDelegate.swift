//
//  AppDelegate.swift
//  Tab App
//
//  Created by Shimon on 9/24/17.
//  Copyright © 2017 dotrothschild. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    
    func startVideo(viewCtrl: UIViewController, name: String) {

        // Start Video
        if let moviePath = Bundle.main.path(forResource: name, ofType: "mp4") {
            // Initialize AVPlayer
            let videoURL = URL(fileURLWithPath: moviePath)
            let player = AVPlayer(url: videoURL)
            player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(viewCtrl, selector: #selector(playerDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = viewCtrl.view.frame.insetBy(dx: 10.0, dy: 44.0)
            // Move AVPlayerViewController to Parent View Controller and start
            
            viewCtrl.addChildViewController(playerViewController)
            viewCtrl.view.addSubview(playerViewController.view)
            playerViewController.didMove(toParentViewController: viewCtrl)
            playerViewController.player!.play()
        } else {
            NSLog("***ERROR: Unable to find resource: %@.mp4", name)
        }
    }
    
    
    func stopVideoNotivications(viewCtrl: UIViewController) {
        
        // Stop Video Notifications
        NotificationCenter.default.removeObserver(self)
        // Stop & Remove AVPlayerController from View if self.childViewControllers.count > 0 {
        if viewCtrl.childViewControllers.count > 0 {
            let pvc = viewCtrl.childViewControllers[0] as! AVPlayerViewController
            pvc.player!.pause()
            pvc.player = nil
            pvc.removeFromParentViewController()
            viewCtrl.view.willRemoveSubview(pvc.view)
        } else {
            NSLog("***ERROR: AVPlayerController was never loaded as a child to this view controller.")
        }
    }
    
    func playerDidReachEnd(notification: NSNotification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: kCMTimeZero)
        }
    }
}

