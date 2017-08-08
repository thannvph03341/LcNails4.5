//
//  EnumSizeCell.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import Foundation
import UIKit

enum EnumSizeCell {
    case imgSanPhamSize
    
    func getSize() -> CGFloat {
        switch self {
        case .imgSanPhamSize:
            return UIScreen.main.bounds.width/3
        }
    }
    
    
}
