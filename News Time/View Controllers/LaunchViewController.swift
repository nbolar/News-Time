//
//  LaunchViewController.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/29/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Network

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchImageView: UIImageView!
    let monitor = NWPathMonitor()
    var timerTest : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        launchImageView.hero.modifiers = [.scale(1.9), .duration(1)]
        let anim : CABasicAnimation = CABasicAnimation.init(keyPath: "transform")
        anim.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        anim.duration = 0.8
        anim.repeatCount = .infinity
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        anim.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.2))
        launchImageView.layer.add(anim, forKey: nil)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.dismissSelf), userInfo: nil, repeats: false)


        

        // Do any additional setup after loading the view.
    }
    
    
//    @objc func setUpUI(){
//        if connected == 1{
//            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissSelf), userInfo: nil, repeats: false)
//            if timerTest != nil {
//                timerTest?.invalidate()
//                timerTest = nil
//
//            }
//        }else{
//            if timerTest == nil {
//            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setUpUI), userInfo: nil, repeats: true)
//        }
//        }
//
//    }
    @objc func dismissSelf(){
        
        self.performSegue(withIdentifier: "rootView", sender: nil)
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
