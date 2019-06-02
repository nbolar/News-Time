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
        self.layer.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2).cgColor
        self.layer.cornerRadius = 10

        

        datePostedLabel.text = "2d"
        datePostedLabel.textColor = .white
//        newsImage.alpha = 0.7
        
    }
    
    func configureCell(newsCell: NewsList){
        let imageURL = URL(string: newsCell.imageURL)
        newsImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//        newsImage.alpha = 0.5
        newsHeadlineLabel.text = newsCell.newsHeadline
        datePostedLabel.text = newsCell.newsProvider
        
    }
    

}
