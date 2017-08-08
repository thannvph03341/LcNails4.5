//
//  HomeCollectionViewCell.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class HomeCollectionViewCell:


UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var dongiaLabel: UILabel!
    @IBOutlet weak var tensanphamLabel: UILabel!
    @IBOutlet weak var like: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        tensanphamLabel.textColor = UIColor.black
        tensanphamLabel.font = UIFont(name: MegaTheme.fontName, size: 14)
        
        dongiaLabel.textColor = UIColor.red//UIColor(white: 0.45, alpha: 1.0)
        dongiaLabel.font = UIFont(name: MegaTheme.fontName, size: 11)
        
//        coverImageView.layer.borderColor = UIColor(white: 0.2, alpha: 1.0).cgColor
//        coverImageView.layer.borderWidth = 0.5
        
    }

    
}
