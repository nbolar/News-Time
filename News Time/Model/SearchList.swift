//
//  SearchList.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/7/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Foundation
import SwiftyJSON


var searchHeadlines = [String]()
var searchContent = [String]()
var searchImages = [String]()
var searchDates = [String]()
var searchContentURL = [String]()
var searchDescription = [String]()
class SearchList{
    
    fileprivate var _newsHeadline: String!
    fileprivate var _newsProvider: String!
    fileprivate var _imageURL: String!
    fileprivate var _datePosted: String!
    
    
    var newsHeadline: String {
        get{
            return _newsHeadline
        } set {
            _newsHeadline = newValue
        }
    }
    
    var newsProvider: String {
        get{
            return _newsProvider
        } set {
            _newsProvider = newValue
        }
    }
    
    var imageURL: String {
        get{
            return _imageURL
        } set {
            _imageURL = newValue
        }
    }
    
    var datePosted: String {
        get{
            return _datePosted
        } set {
            _datePosted = newValue
        }
    }
    
    
    
    
    
    class func loadNewsFromData(_ APIData: Data) -> [SearchList]{
        searchHeadlines.removeAll()
        searchImages.removeAll()
        searchContentURL.removeAll()
        searchContent.removeAll()
        searchDescription.removeAll()
        
        var news = [SearchList]()
        
        let json = try! JSON(data: APIData)
        
        if let list = json["articles"].array{
            for article in list
            {
                let dayNews = SearchList()
                dayNews.newsHeadline = (article["title"].stringValue)
                searchHeadlines.append(article["title"].stringValue)
                searchDescription.append(article["description"].stringValue)
                searchContent.append(article["content"].stringValue)
                dayNews.newsProvider = (article["source"]["name"].stringValue)
                dayNews.imageURL = article["urlToImage"].stringValue
                searchContentURL.append(article["url"].stringValue)
                searchImages.append(article["urlToImage"].stringValue)
                
                
//                let publishedTime = article["publishedAt"].stringValue
                dayNews.datePosted = (article["publishedAt"].stringValue.dateFromTimestamp?.relativelyFormatted(short: false)) ?? ""
                
                news.append(dayNews)
            }
        }
        return news
    }
}
