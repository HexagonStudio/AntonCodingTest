//
//  NewsItem.swift
//  SeedAppInterView
//
//  Created by chad chen on 2018-08-29.
//  Copyright © 2018 chad chen. All rights reserved.
//

import UIKit

struct NewsItem {
    var url: String
    var title: String
    var image: UIImage
    
    static func fetchNews() -> [NewsItem] {
        let file = Bundle.main.path(forResource: "Data", ofType: "plist")
        let array = NSArray(contentsOfFile: file!) as! Array<[String: String]>
        var outputArray = [NewsItem]()
        for item in array {
            let cellData = NewsItem(url: item["url"]!, title: item["title"]!, image: UIImage(named: item["image"]!)!)
            outputArray.append(cellData)
        }
        return outputArray
    }
}
