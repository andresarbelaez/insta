//
//  MyTabBarController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/22/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the default color of the icon of the selected UITabBarItem and Title
        tabBar.items?[0].title = "Feed"
        tabBar.items?[1].title = "Capture"
        tabBar.items?[2].title = "Profile"
        
        
        // Sets the default color of the background of the UITabBar
        let backgroundGreenColor = UIColor(hue: 0.4417, saturation: 0.96, brightness: 0.8, alpha: 1.0) /* #08cc87 */
        UITabBar.appearance().tintColor = backgroundGreenColor
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        
        
        
        
        /*
        // Sets the background color of the selected UITabBarItem (using and plain colored UIImage with the width = 1/5 of the tabBar (if you have 5 items) and the height of the tabBar)
        UITabBar.appearance().selectionIndicatorImage = UIImage().makeImageWithColorAndSize(UIColor.blueColor(), size: CGSizeMake(tabBar.frame.width/3, tabBar.frame.height))
        
        // Uses the original colors for your images, so they aren't not rendered as grey automatically.
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
            }
        }
 
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
