//
//  NewsList.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/30/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Foundation
import SwiftyJSON

var headlines = [String]()
var content = [String]()
var images = [String]()
var dates = [String]()
var contentURL = [String]()
var contentDescription = [String]()
var datePosted = [String]()

class NewsList{
    
    fileprivate var _newsHeadline: String!
    fileprivate var _date: String!
    fileprivate var _imageURL: String!
    
    
    
    var newsHeadline: String {
        get{
            return _newsHeadline
        } set {
            _newsHeadline = newValue
        }
    }
    
    var date: String {
        get{
            return _date
        } set {
            _date = newValue
        }
    }
    
    var imageURL: String {
        get{
            return _imageURL
        } set {
            _imageURL = newValue
        }
    }
    
    

    
    
    class func loadNewsFromData(_ APIData: Data) -> [NewsList]{
        headlines.removeAll()
        content.removeAll()
        images.removeAll()
        contentURL.removeAll()
        contentDescription.removeAll()
        datePosted.removeAll()
        
        var news = [NewsList]()
        
        let json = try! JSON(data: APIData)
        
        if let list = json["articles"].array{
            for article in list
            {
                let dayNews = NewsList()
                dayNews.newsHeadline = (article["title"].stringValue)
                headlines.append(article["title"].stringValue)
                contentDescription.append(article["description"].stringValue)
                content.append(article["content"].stringValue)
                dayNews.date = (article["source"]["name"].stringValue)
                dayNews.imageURL = article["urlToImage"].stringValue
                contentURL.append(article["url"].stringValue)
                images.append(article["urlToImage"].stringValue)
                
                
//                let publishedTime = article["publishedAt"].stringValue
                dayNews.date = (article["publishedAt"].stringValue.dateFromTimestamp?.relativelyFormatted(short: false)) ?? ""
                datePosted.append((article["publishedAt"].stringValue.dateFromTimestamp?.relativelyFormatted(short: false)) ?? "")
                
                
                
//                let date = day["time"].doubleValue
//                let unixConvertedDate = Date(timeIntervalSince1970: date)
//                dayForecast.date = unixConvertedDate.dayOfTheWeek()
                news.append(dayNews)
            }
        }
        return news
    }
    
    
}
