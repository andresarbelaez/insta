//
//  AppDelegate.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/19/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
       /* window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let captureNavigationController = storyboard.instantiateViewControllerWithIdentifier("captureNavigationController") as! UINavigationController
        
       captureNavigationController.tabBarItem.title = "Capture"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [captureNavigationController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible() */
        

        
        
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "insta"
                configuration.clientKey = "asgasdfasdfasdf"
                configuration.server = "https://sleepy-beach-36758.herokuapp.com/parse"
            })
        )
        
        
        
        if PFUser.currentUser() != nil {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PostsNavigationController") as UIViewController
            
            let initViewController: UITabBarController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = initViewController
            self.window?.makeKeyAndVisible()
            //load the home view controller here somehow
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

