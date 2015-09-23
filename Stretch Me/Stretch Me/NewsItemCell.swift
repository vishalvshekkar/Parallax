//
//  NewsItemCell.swift
//  Stretch Me
//
//  Created by Vishal on 9/23/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var news: UILabel!
    
    
    var newsItem: NewsItem? {
        didSet {
            if let item = newsItem {
                category.text = item.category.toString()
                category.textColor = item.category.toColor()
                news.text = item.summary
            }
            else {
                category.text = nil
                news.text = nil
            }
        }
    }
    
    
    
    
}
