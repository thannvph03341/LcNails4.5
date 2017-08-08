//
//  MenuViewCell.swift
//  LcNails
//
//  Created by Lam Tung on 11/29/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class MenuViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    @IBOutlet weak var menuLabel: UILabel!
    
    override var isSelected: Bool{
        didSet{
            menuLabel.textColor = self.isSelected ? UIColor.blue: UIColor.black
        }
    }
    
    
    
}
