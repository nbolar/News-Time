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
    
    var firstTabbarItemImageView: UIImageView!
    var secondTabbarItemImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let viewControllers = viewControllers {
//            selectedViewController = viewControllers[0]
//        }
        let firstItemView = self.tabBar.subviews.first!
        firstTabbarItemImageView = firstItemView.subviews.first as? UIImageView
        firstTabbarItemImageView.contentMode = .center
        
        let secondItemView = self.tabBar.subviews[1]
        secondTabbarItemImageView = secondItemView.subviews.first as? UIImageView
        secondTabbarItemImageView.contentMode = .center
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
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            animate(firstTabbarItemImageView)
        case 1:
            animate(secondTabbarItemImageView)
        default:
            return
        }
    }


}
