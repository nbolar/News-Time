//
//  TabBarVC.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/12/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import SwipeableTabBarController

class TabBarVC: SwipeableTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let viewControllers = viewControllers {
//            selectedViewController = viewControllers[0]
//        }
        
        /// Set the animation type for swipe
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
        /// Set the animation type for tap
        tapAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
        /// if you want cycling switch tab, set true 'isCyclingEnabled'
        isCyclingEnabled = false
        
        /// Disable custom transition on tap.
        //tapAnimatedTransitioning = nil
        
        /// Set swipe to only work when strictly horizontal.
//        diagonalSwipeEnabled = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
