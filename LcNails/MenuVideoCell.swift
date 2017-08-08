//
//  MenuVideoCell.swift
//  LcNails
//
//  Created by Nong Than on 12/12/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class MenuVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageVideoMenu: UIImageView!
    @IBOutlet weak var txtTen: UILabel!
    
    override var isSelected: Bool{
        didSet{
            txtTen.textColor = isSelected ? UIColor.blue: UIColor.black
        }
    }
}
