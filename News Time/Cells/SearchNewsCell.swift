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
        self.layer.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2).cgColor
        self.layer.cornerRadius = 10
        
    }
    
    func configureCell(searchCell : SearchList){
        
        let imageURL = URL(string: searchCell.imageURL)
        searchImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"), options: .init(), completed: nil)//
        searchHeadlineLabel.text = searchCell.newsHeadline
        searchDatePostedLabel.text = searchCell.datePosted
        newsProviderLabel.text = searchCell.newsProvider
        
    }
    
}
