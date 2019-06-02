//
//  SourceList.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/2/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import Foundation
import SwiftyJSON


class SourceList{
    
    class func loadSourceFromData(_ APIData: Data){
        datasourceArray.removeAll()
        datasourceArray2.removeAll()
        
        let json = try! JSON(data: APIData)
        
        if let list = json["sources"].array{
            for source in list
            {
                datasourceArray.append(source["id"].stringValue)
                datasourceArray2.append(source["name"].stringValue)
            }
        }
        
        
    }
}
