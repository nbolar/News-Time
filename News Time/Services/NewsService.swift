//
//  NewsService.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/30/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Foundation
import Alamofire

class NewsService{
    
    static let instance = NewsService()
    fileprivate var _newsList = [NewsList]()
    
    
    var newsList: [NewsList]{
        get{
            return _newsList
        } set {
            _newsList = newValue
        }
    }
    
    
    func downloadNewsDetails (completed: @escaping DownloadComplete)
    {
        
        let url = URL(string: BASE_API_URL)
//        AF.request(url!).responseJSON { (response) in
//            print(response)
//        }
        
        AF.request(url!).responseData { (response) in

            if response.data != nil
            {
                self.newsList = NewsList.loadNewsFromData(response.data!)

            }
            completed()
        }
    }
    
    func downloadSourceDetails (completed: @escaping DownloadComplete)
    {
        
        let url = URL(string: SOURCES_BASE_API_URL)
        //        AF.request(url!).responseJSON { (response) in
        //            print(response)
        //        }
        
        AF.request(url!).responseData { (response) in
            
            if response.data != nil{
                
                SourceList.loadSourceFromData(response.data!)
                
            }
            completed()
        }
    }
}

