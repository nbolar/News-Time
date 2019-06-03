//
//  PopoverContentController.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/1/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit

var datasourceArray = ["abc-news", "al-jazeera-english", "ars-technica", "associated-press", "bbc-news", "bbc-sport", "bloomberg", "business-insider", "buzzfeed", "cbs-news", "cnn"]
var datasourceArray2 = ["ABC News", "Al Jazeera English", "Ars Technica", "Associated Press", "BBC News", "BBC Sport", "Bloomberg", "Business Insider", "Buzzfeed", "CBS News", "CNN"]

var dataCountryArray = ["ar", "at", "au", "be", "bg", "br", "ca", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "sg", "se", "ch", "si", "sk", "za", "th", "tr", "tw", "ae", "ua", "us", "ve"]
var dataCountryArray2 = [ "Argentina", "Austria", "Australia", "Belgium", "Bulgaria", "Brazil", "Canada", "China", "Colombia", "Cuba", "Czech Republic", "Germany", "Egypt", "France", "Great Britain", "Greece", "Hong Kong", "Hungary", "Indonesia", "Ireland", "Israel", "India", "Italy", "Japan", "South Korea", "Lithuania", "Latvia", "Morocco", "Mexico", "Malaysia", "Nigeria", "Netherlands", "Norway", "New Zealand", "Philippines", "Poland", "Portugal", "Romania", "Serbia", "Russia", "Saudi Arabia", "Singapore", "Sweden" , "Switzerland", "Slovenia", "Slovakia", "South Africa", "Thailand", "Turkey", "Taiwan", "UAE","Ukraine", "USA", "Venezuela" ]

protocol PopoverContentControllerDelegate:class {
    func popoverContent(controller:PopoverContentController, didselectItem name:String)
}


class PopoverContentController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate:PopoverContentControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.layer.cornerRadius = 8
        self.view.layer.backgroundColor = UIColor.black.cgColor
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        }else{
            return dataCountryArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesCell", for: indexPath)
        if popoverButton == 1{
            cell.textLabel?.text = dataCountryArray2[indexPath.row]
        }else{
            cell.textLabel?.text = datasourceArray2[indexPath.row]
        }
        
        cell.textLabel?.textColor = .white
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if popoverButton == 2{
            let selectedSource = datasourceArray2[indexPath.row]
            self.delegate?.popoverContent(controller: self, didselectItem: selectedSource)
            SOURCES = datasourceArray[indexPath.row]
            BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?sources=\(SOURCES)&pageSize=50&apiKey=\(API_KEY)"
        }else{
            let selectedSource = dataCountryArray2[indexPath.row]
            self.delegate?.popoverContent(controller: self, didselectItem: selectedSource)
            COUNTRY = dataCountryArray[indexPath.row].lowercased()
            BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?country=\(COUNTRY)&pageSize=50&apiKey=\(API_KEY)"
        }

        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    

}
