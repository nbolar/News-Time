//
//  PopoverContentController.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/1/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import ViewAnimator
import FontAwesome_swift

var datasourceArray = ["abc-news", "al-jazeera-english", "ars-technica", "associated-press", "bbc-news", "bbc-sport", "bloomberg", "business-insider", "buzzfeed", "cbs-news", "cnn"]
var datasourceArray2 = ["ABC News", "Al Jazeera English", "Ars Technica", "Associated Press", "BBC News", "BBC Sport", "Bloomberg", "Business Insider", "Buzzfeed", "CBS News", "CNN"]

var dataCountryArray = ["ar", "at", "au", "be", "bg", "br", "ca", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "sg", "se", "ch", "si", "sk", "za", "th", "tr", "tw", "ae", "ua", "us", "ve"]
var dataCountryArray2 = [ "Argentina", "Austria", "Australia", "Belgium", "Bulgaria", "Brazil", "Canada", "China", "Colombia", "Cuba", "Czech Republic", "Germany", "Egypt", "France", "Great Britain", "Greece", "Hong Kong", "Hungary", "Indonesia", "Ireland", "Israel", "India", "Italy", "Japan", "South Korea", "Lithuania", "Latvia", "Morocco", "Mexico", "Malaysia", "Nigeria", "Netherlands", "Norway", "New Zealand", "Philippines", "Poland", "Portugal", "Romania", "Serbia", "Russia", "Saudi Arabia", "Singapore", "Sweden" , "Switzerland", "Slovenia", "Slovakia", "South Africa", "Thailand", "Turkey", "Taiwan", "UAE","Ukraine", "USA", "Venezuela" ]

var categoryArray = ["Business","Entertainment", "General", "Health", "Science", "Sports", "Technology"]

protocol PopoverContentControllerDelegate:class {
    func popoverContent(controller:PopoverContentController, didselectItem name:String)
}


class PopoverContentController: UIViewController {
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    var scrollView: UIScrollView {
        return tableView
    }

    @IBOutlet weak var tableView: UITableView!
    var delegate:PopoverContentControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.layer.cornerRadius = 8
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: nil)
        if darkMode == 1{
            tableView.backgroundColor = .black
            view.backgroundColor = .black
            tableView.separatorColor = .lightGray
            scrollView.indicatorStyle = .white
//            tableView.showsVerticalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true

        }else{
            tableView.backgroundColor = .white
            view.backgroundColor = .white
            tableView.separatorColor = .lightGray
            scrollView.indicatorStyle = .black
//            tableView.showsVerticalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
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


}

extension PopoverContentController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if popoverButton == 2{
            return datasourceArray.count
        }else if popoverButton == 1{
            return dataCountryArray.count
        }else{
            return categoryArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        if popoverButton == 1{
            cell.textLabel?.text = dataCountryArray2[indexPath.row]
        }else if popoverButton == 2{
            cell.textLabel?.text = datasourceArray2[indexPath.row]
        }else{
            cell.textLabel?.text = categoryArray[indexPath.row]
        }
        if darkMode == 0{
            cell.contentView.backgroundColor = .white
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
        }else{
            cell.contentView.backgroundColor = .black
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if popoverButton == 2{
            let selectedSource = datasourceArray2[indexPath.row]
            self.delegate?.popoverContent(controller: self, didselectItem: selectedSource)
            SOURCES = datasourceArray[indexPath.row]
            BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?sources=\(SOURCES)&pageSize=50&apiKey=\(API_KEY)"
            
        }else if popoverButton == 1{
            let selectedSource = dataCountryArray2[indexPath.row]
            self.delegate?.popoverContent(controller: self, didselectItem: selectedSource)
            COUNTRY = dataCountryArray[indexPath.row].lowercased()
            BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?country=\(COUNTRY)&pageSize=50&apiKey=\(API_KEY)"
        }else{
            let selectedSource = categoryArray[indexPath.row]
            self.delegate?.popoverContent(controller: self, didselectItem: selectedSource)
            BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?country=\(COUNTRY)&category=\(selectedSource)&pageSize=50&apiKey=\(API_KEY)"
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "alpha"), object: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    

}
