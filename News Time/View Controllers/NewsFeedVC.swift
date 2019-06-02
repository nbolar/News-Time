//
//  NewsFeedVC.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/26/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Hero


var indexSelected: IndexPath!
var updatedString : String!
var layout = 0
var popoverButton = 0

class NewsFeedVC: UIViewController, UIPopoverPresentationControllerDelegate{

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
        let labelYPostion:CGFloat = 150
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
        
        
        
        navigationItem.title = "News Feed"
        
        collectionView.addSubview(refreshControl)
//        view.addSubview(label)
        
//        self.view.addSubview(button)
        
        
//        collectionView.register(NewsFeedCell.self, forCellWithReuseIdentifier: "NewsFeedCell")
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
    
    
    @IBAction func showCountryPopoverClicked(_ sender: Any) {
        popoverButton = 1
        //Configure the presentation controller
        let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverContentController") as? PopoverContentController
        popoverContentController?.modalPresentationStyle = .popover
        popoverContentController?.preferredContentSize = CGSize(width: 155, height: 300)
        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.barButtonItem = self.countryButton
            
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
        popoverContentController?.preferredContentSize = CGSize(width: 250, height: 400)
        
        /* 3 */
        if let popoverPresentationController = popoverContentController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.sourcesButton
            popoverPresentationController.sourceRect = sourcesButton.frame
            popoverPresentationController.delegate = self
            
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
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
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
        refreshNewsFeed((Any).self)
        refreshButton.isEnabled = false
        collectionView.isHidden = true
        label.isHidden = false
        view.addSubview(label)
    }
    
    @objc private func refreshNewsFeed(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.downloadNewsArticles()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(stopRefreshing), userInfo: nil, repeats: false)
        
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
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexpath = self.collectionView?.indexPath(for: cell) else { return }
                vc.articleHeadlineString = headlines[indexpath.row]
                vc.articleContentString = content[indexpath.row]
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