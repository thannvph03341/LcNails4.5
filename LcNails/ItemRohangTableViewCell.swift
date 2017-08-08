//
//  ItemRohangTableViewCell.swift
//  LcNails
//
//  Created by Lam Tung on 11/24/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class ItemRohangTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTenSanPham: UILabel!
    @IBOutlet weak var txtGiaSanPham: UILabel!
    @IBOutlet weak var txtSoLuong: UILabel!
    
    @IBOutlet weak var txtTongTien: UILabel!
    
    @IBOutlet weak var imgSanPham: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
