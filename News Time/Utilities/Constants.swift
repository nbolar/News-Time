//
//  Constants.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/30/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Foundation


typealias DownloadComplete = () -> ()

let NOTIF_DOWNLOAD_COMPLETE = NSNotification.Name("dataDownloaded")


var API_KEY = "YOUR_KEY"
var ENDPOINT = "top-headlines"
var COUNTRY = "us"
var SOURCES = ""
var SEARCH_TERM = ""
var BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?country=\(COUNTRY)&pageSize=50&apiKey=\(API_KEY)"
var SEARCH_BASE_API_URL = "https://newsapi.org/v2/everything?q=\(SEARCH_TERM)&apiKey=\(API_KEY)"
var SOURCES_BASE_API_URL = "https://newsapi.org/v2/sources?apiKey=\(API_KEY)"
