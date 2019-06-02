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


var API_KEY = "9eca91b2275d4214bd7f6b88f726f3df"
var ENDPOINT = "top-headlines"
var COUNTRY = "us"
var SOURCES = ""
var BASE_API_URL = "https://newsapi.org/v2/\(ENDPOINT)?country=\(COUNTRY)&pageSize=50&apiKey=\(API_KEY)"
var SOURCES_BASE_API_URL = "https://newsapi.org/v2/sources?apiKey=\(API_KEY)"
