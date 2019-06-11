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
//        self.layer.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2).cgColor
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.4)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    func configureCell(newsCell: NewsList){
        let imageURL = URL(string: newsCell.imageURL)
        articleImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//        newsImage.alpha = 0.5
        articleHealineLabel.text = newsCell.newsHeadline
        datePostedLabel.text = "◉ \(newsCell.newsProvider)"
        
    }
}
