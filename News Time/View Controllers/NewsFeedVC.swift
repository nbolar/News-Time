//
//  NewsFeedVC.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/26/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Hero
import PullToReach


var indexSelected: IndexPath!
var updatedString : String!
var layout = 0
var popoverButton = 0

class NewsFeedVC: UIViewController, UIPopoverPresentationControllerDelegate, PullToReach {
 
    
    
    var scrollView: UIScrollView {
        return collectionView
    }
    @IBOutlet weak var layoutButton: UIBarButtonItem!
    @IBOutlet weak var countryButton: UIBarButtonItem!
    @IBOutlet weak var sourcesButton: UIButton!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    let button = UIButton(type: UIButton.ButtonType.system) as UIButton
    let label = UILabel()
    let refreshControl = UIRefreshControl()
  
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.scrollsToTop = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        collectionView.alwaysBounceVertical = true
        
        sourcesButton.titleLabel?.lineBreakMode = .byWordWrapping
        sourcesButton.titleLabel?.numberOfLines = 2
        sourcesButton.setTitle("Sources ⩡", for: .normal)
        sourcesButton.target(forAction: #selector(showCountryButton), withSender: nil)
        
        let timeInterval = 1.0
        collectionView.hero.modifiers = [.scale(1.2), .duration(timeInterval)]
        for cell in collectionView.visibleCells
        {
            cell.hero.modifiers = [.fade, .scale(0.5)]
        }
        label.hero.modifiers = [.fade, .translate(x: 0, y: -300, z: 0)]
        
        
        
        
        let xPostion:CGFloat = view.bounds.width / 2 - 50
        let yPostion:CGFloat = view.bounds.height - 48
        let buttonWidth:CGFloat = 100
        let buttonHeight:CGFloat = 25
        
        
        let labelXPostion:CGFloat = view.bounds.width / 2 - 115
        let labelYPostion:CGFloat = 180
        let labelWidth:CGFloat = 230
        let labelHeight:CGFloat = 25
        
        
        label.frame = CGRect(x: labelXPostion, y: labelYPostion, width: labelWidth, height: labelHeight)
        label.text = "Fetching Latest News Articles"
        label.textColor = .gray
        label.backgroundColor = .clear
        
        button.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        button.layer.cornerRadius = 12
        button.backgroundColor = .white
        button.setTitle("Scroll to Top", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.alpha = 0.7
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(refreshNewsFeed(_:)), for: .valueChanged)
        let refreshString = "Fetching Latest News Articles"
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: refreshString, attributes: attributes)
        refreshControl.tintColor = .white
    
        refreshButton.action = #selector(refreshNewsFeedButton)
        countryButton.action = #selector(showCountryButton)
        layoutButton.action = #selector(layoutButtonClicked)

        navigationItem.title = "News Feed"
        
//        collectionView.refreshControl = refreshControl
        
        self.navigationItem.rightBarButtonItems = [
            refreshButton,
            countryButton
            ]
        self.navigationItem.leftBarButtonItems = [layoutButton]
        self.activatePullToReach(on: navigationItem, highlightColor: .gray)
        

        
        

        

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        updatedString = "\(formatter.string(from: currentDateTime))"

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        self.title = "News Feed \n\(updatedString!)"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .heavy)
        ]
        
        for navItem in(self.navigationController?.navigationBar.subviews)! {
            for itemSubView in navItem.subviews {
                if let largeLabel = itemSubView as? UILabel {
                    largeLabel.text = self.title
                    largeLabel.numberOfLines = 0
                    largeLabel.sizeToFit()
                    largeLabel.lineBreakMode = .byCharWrapping
                }
            }
        }
        
//        navigationItem.titleView = setTitle(title: "News Feed", subtitle: "\(updatedString!)")
        
    }
    
    @objc func showCountryButton(){
        showCountryPopoverClicked((Any).self)
    }
    
    @objc func showSourcesButton(){
        showPopoverButtonClicked((Any).self)
    }
    
    

    
    
    @IBAction func showCountryPopoverClicked(_ sender: Any) {
        popoverButton = 1
        
        let barButtonItem = self.navigationItem.rightBarButtonItems?[1]
        guard let view = barButtonItem?.value(forKey: "view") as? UIView else { return }
        
        view.transform = CGAffineTransform(rotationAngle: CGFloat())
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = 1.0
        
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        //Configure the presentation controller
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover
        popoverContentController?.preferredContentSize = CGSize(width: 155, height: 300)
    
        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.barButtonItem = self.countryButton
            popoverPresentationController.backgroundColor = .black
            
//            popoverPresentationController.sourceView = self.countryButton
//            popoverPresentationController.sourceRect = countryButton.frame
            popoverPresentationController.delegate = self
            
            popoverContentController?.delegate = self as PopoverContentControllerDelegate
            if let popoverController = popoverContentController {
                present(popoverController, animated: true, completion: nil)
                
                
            }
        }
    }
    
    @IBAction func showPopoverButtonClicked(_ sender: Any) {
        popoverButton = 2
        //Configure the presentation controller
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover
        popoverContentController?.preferredContentSize = CGSize(width: 250, height: 500)
        
        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.sourcesButton
            popoverPresentationController.sourceRect = sourcesButton.frame
            popoverPresentationController.delegate = self
            popoverPresentationController.backgroundColor = .black
            
            
            popoverContentController?.delegate = self as PopoverContentControllerDelegate
            if let popoverController = popoverContentController {
                
                present(popoverController, animated: true, completion: nil)
                
                
            }
        }
    }
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        setAlphaOfBackgroundViews(alpha: 1)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        setAlphaOfBackgroundViews(alpha: 0.4)
    }
    
    func setAlphaOfBackgroundViews(alpha: CGFloat) {
        let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
        UIView.animate(withDuration: 0.2) {
            statusBarWindow?.alpha = alpha
            self.view.alpha = alpha
            self.navigationController?.navigationBar.alpha = alpha
            self.tabBarController?.tabBar.alpha = alpha
        }
    }
    
    
    
    
    
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        let anim : CABasicAnimation = CABasicAnimation.init(keyPath: "transform")
        anim.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        anim.duration = 0.8
        anim.repeatCount = 2
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        anim.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.2))
        label.layer.add(anim, forKey: nil)
        
        let barButtonItem = self.navigationItem.rightBarButtonItems?[0]
        guard let view = barButtonItem?.value(forKey: "view") as? UIView else { return }
        
        view.transform = CGAffineTransform(rotationAngle: CGFloat())
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 1.5
        rotationAnimation.repeatCount = 2.0
        
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
        
        
        refreshNewsFeed((Any).self)
        refreshButton.isEnabled = false
        collectionView.isHidden = true
        label.isHidden = false
//        view.addSubview(label)
        collectionView.isHidden = true
    }
    
    
    @objc private func refreshNewsFeed(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.downloadNewsArticles()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(stopRefreshing), userInfo: nil, repeats: false)
        
    }
    
    @objc private func refreshNewsFeedButton() {
        refreshButtonClicked((Any).self)
        
    }
    
    @objc func stopRefreshing(){
        collectionView.isHidden = false
        label.isHidden = true
        collectionView.reloadData()
        self.refreshControl.endRefreshing()
        refreshButton.isEnabled = true
        let indepath = IndexPath(row: 0, section: 0)
        collectionView.scrollToItem(at: indepath, at: .top, animated: true)
        
    }
    @objc func buttonAction(_ sender:UIButton!)
    {
        let indexpath = IndexPath(row: 0, section: 0)
        collectionView.scrollToItem(at: indexpath, at: .top, animated: true)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showTab), userInfo: nil, repeats: false)
        
    }
    
    @objc func showTab(){
        self.button.isHidden = true
        changeTabBar(hidden: false, animated: true)
        
    }
    @objc func layoutButtonClicked(){
        changeLayout((Any).self)
    }
    
    @IBAction func changeLayout(_ sender: Any) {
        if layout == 0
        {
            layout = 1
            navigationItem.leftBarButtonItem?.image = UIImage(named: "grid")
            collectionView.reloadData()
        }else{
            layout = 0
            navigationItem.leftBarButtonItem?.image = UIImage(named: "list")
            collectionView.reloadData()
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let anim : CABasicAnimation = CABasicAnimation.init(keyPath: "transform")
        anim.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        anim.duration = 0.8
        anim.repeatCount = 2
        anim.autoreverses = true
        anim.isRemovedOnCompletion = true
        anim.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.3))
        button.layer.add(anim, forKey: nil)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        if(((scrollView.panGestureRecognizer.translation(in: scrollView).x) <= -10) && ((scrollView.panGestureRecognizer.translation(in: scrollView).x) > -20)){
//
//            let labelXPostion:CGFloat = (navigationItem.titleView?.bounds.width)! / 2 - 50
//            let labelYPostion:CGFloat = 30
//            let labelWidth:CGFloat = 100
//            let labelHeight:CGFloat = 25
//
//            
//            label.frame = CGRect(x: labelXPostion, y: labelYPostion, width: labelWidth, height: labelHeight)
//            label.text = "Refresh Feed"
//            label.textColor = .white
//            label.backgroundColor = .clear
//            navigationItem.titleView?.addSubview(label)
//
//        }
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            self.view.addSubview(button)
            self.button.isHidden = false

            changeTabBar(hidden: true, animated: true)
        }
        else{
            self.button.isHidden = true
            changeTabBar(hidden: false, animated: true)
        }
    }
    
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailNewsSegue"{
            if let vc = segue.destination as? DetailNewsVC{
                viewControllerClicked = 0
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexpath = self.collectionView?.indexPath(for: cell) else { return }
                vc.articleHeadlineString = headlines[indexpath.row]
                if content[indexpath.row] != "" && contentDescription[indexpath.row] != ""
                {
                    if contentDescription[indexpath.row][0...10] == content[indexpath.row][0...10]{
                        if content[indexpath.row].count > 259{
                            vc.articleContentString = content[indexpath.row][0..<259]
                        }else{
                            vc.articleContentString = content[indexpath.row]
                        }
                    }else{
                        if content[indexpath.row].count > 259{
                            vc.articleContentString = "\(contentDescription[indexpath.row])\n" + "\(content[indexpath.row][0..<259])"
                        }else{
                            vc.articleContentString = "\(contentDescription[indexpath.row])\n" + "\(content[indexpath.row])"
                        }

                    }
                }else{
                    vc.articleContentString = "\(contentDescription[indexpath.row])\n" + "\(content[indexpath.row])"
                }

               
                vc.imageURL = images[indexpath.row]
                vc.urlToArticle = contentURL[indexpath.row]
            }
        }
    }
    
    @objc func scrollToTop(){
        let indexpath = IndexPath(row: 0, section: 0)
        collectionView.scrollToItem(at: indexpath, at: .top, animated: true)
    }

}

extension NewsFeedVC:PopoverContentControllerDelegate {
    func popoverContent(controller: PopoverContentController, didselectItem name: String) {
        sourcesButton.setTitle(name + " ⩡", for: .normal)
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(refreshNewsFeed(_:)), userInfo: nil, repeats: false)
    }
}


extension NewsFeedVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsService.instance.newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if layout == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
            cell.configureCell(newsCell: NewsService.instance.newsList[indexPath.item])
            
            
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! SectionNewsFeedCell
            cell.configureCell(newsCell: NewsService.instance.newsList[indexPath.item])
            
            
            return cell
        }
        

        
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if layout == 0{
            var itemHeight: CGFloat {
                return collectionView.bounds.width - 35
            }
            
            var itemWidth: CGFloat {
                return collectionView.bounds.width - 35
            }
            
            return CGSize(width: itemWidth, height: itemHeight)
        } else{
            var itemHeight: CGFloat {
                return 100
            }
            
            var itemWidth: CGFloat {
                return collectionView.bounds.width - 35
            }
            
            return CGSize(width: itemWidth, height: itemHeight)
            
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.alpha = 0.4
        let timeInterval = 0.5
        cell?.hero.modifiers = [.fade, .translate(x: 0, y: -150, z: 0), .duration(timeInterval)]
        //        cell?.hero.modifiers = [.size(CGSize(width: cell!.bounds.width, height: cell!.bounds.width - 35)), .translate(x: 0, y: -300, z: 0), .fade, .duration(1)]
        self.performSegue(withIdentifier: "detailNewsSegue", sender: cell)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCell", for: indexPath)
        
        return footerView
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
    
    
    
    
}
class ScalingButton: UIButton {
    
    override func applyStyle(isHighlighted: Bool, highlightColor: UIColor) {
        let scale: CGFloat = isHighlighted ? 1.5 : 1.0
        transform = CGAffineTransform(translationX: scale, y: scale)
        print("Hello")
    }
    
}
