//
//  ItemCommentVideoTableViewCell.swift
//  LcNails
//
//  Created by Lam Tung on 11/27/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class ItemCommentVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTenNguoiBinh: UILabel!
    @IBOutlet weak var txtThoiGian: UILabel!
    @IBOutlet weak var txtLoiBinh: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
