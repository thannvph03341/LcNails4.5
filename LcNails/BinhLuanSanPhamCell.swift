//
//  BinhLuanSanPhamCell.swift
//  LcNails
//
//  Created by Nong Than on 12/7/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class BinhLuanSanPhamCell: UITableViewCell {

    
    @IBOutlet weak var txtTenNguoiBinh: UILabel!
    @IBOutlet weak var txtNoiDungBinh: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
