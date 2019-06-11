//
//  SearchVC.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/6/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import PullToReach

class SearchVC: UIViewController, PullToReach {
    var scrollView: UIScrollView{
        return collectionView
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.becomeFirstResponder()
        navigationItem.searchController?.searchBar.becomeFirstResponder()
//        searchController.searchBar.keyboardAppearance = .dark
//        searchController.searchBar.showsCancelButton = false
//        searchController.searchBar.tintColor = .white
        
        collectionView.scrollsToTop = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
//        collectionView.alwaysBounceVertical = true
        
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News Stories"
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.delegate = self
//        searchController.searchResultsUpdater = self
        
        let timeInterval = 1.0
        collectionView.hero.modifiers = [.scale(1.2), .duration(timeInterval)]
        for cell in collectionView.visibleCells
        {
            cell.hero.modifiers = [.fade, .scale(0.5)]
        }
        
        if tabBarController?.tabBar.barTintColor == .black{
            scrollView.indicatorStyle = .white
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.view.backgroundColor = .black
            navigationController?.navigationBar.barStyle = .black
            collectionView.backgroundColor = .black
            searchController.searchBar.tintColor = .white
            navigationItem.titleView?.tintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ]
            searchController.searchBar.tintColor = .white
            searchController.searchBar.keyboardAppearance = .dark
        }else if tabBarController?.tabBar.barTintColor == .white{
            collectionView.backgroundColor = .white
            scrollView.indicatorStyle = .black
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.view.backgroundColor = .white
            searchController.searchBar.backgroundColor = .white
            navigationItem.titleView?.backgroundColor = .clear
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            ]
            searchController.searchBar.tintColor = .black
            searchController.searchBar.keyboardAppearance = .light
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(setBackground), name: NSNotification.Name(rawValue: "alpha2"), object: nil)
  
        
    }

    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setBackground(){
//        print("Hello")
        if darkMode == 0{
            collectionView.backgroundColor = .white
            scrollView.indicatorStyle = .black
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.view.backgroundColor = .white
            searchController.searchBar.backgroundColor = .white
            navigationItem.titleView?.backgroundColor = .clear
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            ]
            searchController.searchBar.tintColor = .black
            searchController.searchBar.keyboardAppearance = .light

        }else if darkMode == 1{
            scrollView.indicatorStyle = .white
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.view.backgroundColor = .black
            navigationController?.navigationBar.barStyle = .black
            collectionView.backgroundColor = .black
            searchController.searchBar.tintColor = .white
            navigationItem.titleView?.tintColor = .white
            self.navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ]
            searchController.searchBar.tintColor = .white
            searchController.searchBar.keyboardAppearance = .dark
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
    @IBAction func unwindToVC2(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetailNewsSegue"{
            if let vc = segue.destination as? DetailNewsVC{
                viewControllerClicked = 1
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexpath = self.collectionView?.indexPath(for: cell) else { return }
                vc.articleHeadlineString = searchHeadlines[indexpath.row]
                vc.datePosted = searchDatePosted[indexpath.row]
                if searchContent[indexpath.row] != "" && searchDescription[indexpath.row] != ""
                {
                    if searchDescription[indexpath.row][0...10] == searchContent[indexpath.row][0...10]{
                        if searchContent[indexpath.row].count > 259{
                            vc.articleContentString = searchContent[indexpath.row][0..<259]
                        }else{
                            vc.articleContentString = searchContent[indexpath.row]
                        }
                    }else{
                        if searchContent[indexpath.row].count > 259{
                            vc.articleContentString = "\(searchDescription[indexpath.row])\n" + "\(searchContent[indexpath.row][0..<259])"
                        }else{
                            vc.articleContentString = "\(searchDescription[indexpath.row])\n" + "\(searchContent[indexpath.row])"
                        }
                        
                    }
                }else{
                    vc.articleContentString = "\(searchDescription[indexpath.row])\n" + "\(searchContent[indexpath.row])"
                }
                vc.imageURL = searchImages[indexpath.row]
                vc.urlToArticle = searchContentURL[indexpath.row]
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            changeTabBar(hidden: true, animated: true)
            navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        }
        else{
            navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
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
    

}


extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsService.instance.searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchNewsCell", for: indexPath) as! SearchNewsCell
        cell.configureCell(searchCell: NewsService.instance.searchList[indexPath.row])
        return cell
 
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemHeight: CGFloat {
            return collectionView.bounds.width - 35
        }
        
        var itemWidth: CGFloat {
            return collectionView.bounds.width - 35
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.alpha = 0.4
        let timeInterval = 0.5
        cell?.hero.modifiers = [.fade, .translate(x: 0, y: -150, z: 0), .duration(timeInterval)]
        //        cell?.hero.modifiers = [.size(CGSize(width: cell!.bounds.width, height: cell!.bounds.width - 35)), .translate(x: 0, y: -300, z: 0), .fade, .duration(1)]
        self.performSegue(withIdentifier: "searchDetailNewsSegue", sender: cell)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)

    }
}

extension SearchVC: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        if text != ""
        {
            searchController.searchBar.text = nil
            searchController.searchBar.placeholder = "\(text)"
            SEARCH_TERM = text.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
            SEARCH_BASE_API_URL = "https://newsapi.org/v2/everything?q=\(SEARCH_TERM)&apiKey=\(API_KEY)"
            NewsService.instance.downloadListSearchDetails {
                NotificationCenter.default.post(name: NOTIF_DOWNLOAD_COMPLETE, object: nil)
                self.collectionView.reloadData()
            }

        }
        
        collectionView.reloadData()
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.keyboardAppearance = .dark
    }
    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        // TODO
//        guard let text = searchController.searchBar.text else { return }
//        if text != ""
//        {
//            SEARCH_TERM = text
//            SEARCH_BASE_API_URL = "https://newsapi.org/v2/everything?q=\(SEARCH_TERM)&apiKey=\(API_KEY)"
//            listSearchCall()
//
//        }
//
//        collectionView.reloadData()
//    }
//
//
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

