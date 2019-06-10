//
//  SectionNewsFeedCell.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/31/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit

class SectionNewsFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleHealineLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2).cgColor
        self.layer.cornerRadius = 10
        
    }
    
    func configureCell(newsCell: NewsList){
        let imageURL = URL(string: newsCell.imageURL)
        articleImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//        newsImage.alpha = 0.5
        articleHealineLabel.text = newsCell.newsHeadline
        datePostedLabel.text = "◉ \(newsCell.newsProvider)"
        
    }
}
