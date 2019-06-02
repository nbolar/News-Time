//
//  DetailNewsVC.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/26/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Hero
import SafariServices

class DetailNewsVC: UIViewController {

    
    @IBOutlet weak var articleHeadline: UILabel!
    @IBOutlet weak var newsArticleContent: UITextView!
    @IBOutlet weak var newsArticleImage: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var openURLButton: UIButton!
    
    var articleHeadlineString = ""
    var articleContentString = ""
    var imageURL = ""
    var urlToArticle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timeInterval = 0.5
        backButton.hero.modifiers = [.fade, .translate(x: 0, y: -150, z: 0), .duration(1)]
        
        newsArticleImage.hero.modifiers = [.translate(x: 0, y: 75, z: 0), .duration(timeInterval)]
        articleHeadline.hero.modifiers = [.scale(1.2), .duration(1)]
        newsArticleContent.hero.modifiers = [.scale(1.2), .duration(1)]
//        openURLButton.hero.modifiers = [.scale(1.2), .duration(1)]
        openURLButton.layer.cornerRadius = 10
        
        openURLButton.setTitle("Read the entire article ⟶", for: .normal)
        
        
        
        articleHeadline.text = articleHeadlineString
        if articleContentString.count > 259  {
            newsArticleContent.text = articleContentString[0..<259]
        }else {
            newsArticleContent.text = articleContentString
        }
        
        let editedImageURL = URL(string: imageURL)
        newsArticleImage.sd_setImage(with: editedImageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)
    
//        newsArticleContent.scrollRangeToVisible(NSMakeRange(0, 0))
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let anim : CABasicAnimation = CABasicAnimation.init(keyPath: "transform")
        anim.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        anim.duration = 0.8
        anim.repeatCount = 2
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        anim.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.1))
        openURLButton.layer.add(anim, forKey: nil)
    }
    
    @IBAction func openURLButtonClicked(_ sender: UIButton) {
        let editedContentURl = URL(string: urlToArticle)
        
        let config = SFSafariViewController.Configuration()
//        config.entersReaderIfAvailable = true
        let safariController = SFSafariViewController.init(url: editedContentURl!, configuration: config)
        safariController.delegate = self as? SFSafariViewControllerDelegate
        safariController.preferredBarTintColor = .black
        self.present(safariController, animated: true, completion: nil)
        
    }
    
    @IBAction func dismissVC(_ sender: UIPanGestureRecognizer) {
        
        if sender.velocity(in: nil).y > 0
        {
            
            
            let translation = sender.translation(in: nil)
            let progress = translation.y / 2 / view.bounds.height
            
            switch sender.state {
            case .began:
                performSegue(withIdentifier: "newsFeedView", sender: self)
            case .changed:
                Hero.shared.update(progress)
                let currentPosition = CGPoint(x: translation.x + newsArticleImage.center.x, y: translation.y + newsArticleImage.center.y)
                Hero.shared.apply(modifiers: [.position(currentPosition)], to: newsArticleImage)
            default:
                if progress + sender.velocity(in: nil).y / view.bounds.height > 0.1
                {
                    Hero.shared.finish()
                }else{
                    Hero.shared.cancel()
                }
                
            }
            
        } else{
            Hero.shared.cancel()
        }
    }
    
//    @IBAction func swipeToDismiss(_ sender: UISwipeGestureRecognizer?) {
////        presentingViewController?.dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "newsFeedView", sender: self)
//        
//    }
    override var prefersStatusBarHidden: Bool {
        return true
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
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
}
}

