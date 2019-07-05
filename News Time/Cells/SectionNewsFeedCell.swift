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
//        contentView.layer.cornerRadius = 15.0
        articleImageView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .clear
        setAlpha()
        NotificationCenter.default.addObserver(self, selector: #selector(setAlpha), name: NSNotification.Name(rawValue: "alpha2"), object: nil)
        
    }

    
    @objc func setAlpha(){
        
        if darkMode == 1{
            datePostedLabel.textColor = .white
            articleHealineLabel.textColor = .white
        }else{
            datePostedLabel.textColor = .black
            articleHealineLabel.textColor = .black
        }
    }
    
    func configureCell(newsCell: NewsList){

        let imageURL = URL(string: newsCell.imageURL)
        articleImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//        newsImage.alpha = 0.5
        articleHealineLabel.text = newsCell.newsHeadline
        datePostedLabel.text = "◉ \(newsCell.newsProvider)"
        
    }
}
