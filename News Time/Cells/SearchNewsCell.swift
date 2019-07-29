//
//  SearchNewsCell.swift
//  News Time
//
//  Created by Nikhil Bolar on 6/7/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit
import SDWebImage

class SearchNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchHeadlineLabel: UILabel!
    @IBOutlet weak var searchDatePostedLabel: UILabel!
    @IBOutlet weak var newsProviderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 20.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.init(white: 1.0, alpha: 0.2).cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    func configureCell(searchCell : SearchList){
        
        let imageURL = URL(string: searchCell.imageURL)
        searchImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//
        searchHeadlineLabel.text = searchCell.newsHeadline
        searchDatePostedLabel.text = "◉ \(searchCell.datePosted)"
        newsProviderLabel.text = searchCell.newsProvider
        
    }
    
}
