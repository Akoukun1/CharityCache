//
//  CategoryCollectionViewCell.swift
//  CharityCache
//
//  Created by Aditya Koukuntla on 11/19/16.
//  Copyright © 2016 CharityCache. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
         self.categoryImageView.layer.borderColor = UIColor.green.cgColor
         self.categoryImageView.layer.borderWidth = 2
        self.categoryImageView.layer.cornerRadius = self.categoryImageView.frame.width/2
        self.categoryImageView.clipsToBounds = true
    }
}
