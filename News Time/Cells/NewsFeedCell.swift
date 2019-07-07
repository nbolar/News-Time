//
//  NewsFeedCell.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/26/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import Hero
import SDWebImage

class NewsFeedCell: UICollectionViewCell {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 20.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor

        

        

        datePostedLabel.text = "2d"
        datePostedLabel.textColor = .white
//        newsImage.alpha = 0.7
        
    }
    
    func configureCell(newsCell: NewsList){
        let imageURL = URL(string: newsCell.imageURL)
        newsImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//        newsImage.alpha = 0.5
        newsHeadlineLabel.text = newsCell.newsHeadline
        datePostedLabel.text = "◉ \(newsCell.date)"
        
    }
    

}
