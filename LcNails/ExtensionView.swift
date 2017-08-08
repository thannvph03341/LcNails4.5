//
//  ExtensionView.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsArray(withVisualFormat:String, views:UIView...){
        
        var arrayView = [String:UIView]()
        for (index, items) in views.enumerated() {
            let key = "v\(index)"
            items.translatesAutoresizingMaskIntoConstraints = false
            arrayView[key] = items
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withVisualFormat, options: NSLayoutFormatOptions(), metrics: nil, views: arrayView))
    }
    
}
