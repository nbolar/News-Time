//
//  FooterCell.swift
//  News Time
//
//  Created by Nikhil Bolar on 5/28/19.
//  Copyright © 2019 Nikhil Bolar. All rights reserved.
//

import UIKit

class FooterCell: UICollectionViewCell {
    @IBOutlet weak var newsAPIImageView: UIImageView!
    
    override func awakeFromNib() {
        self.newsAPIImageView.layer.cornerRadius = 10
    }
    
}
