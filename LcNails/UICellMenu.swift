//
//  UICellMenu.swift
//  LcNails
//
//  Created by Nong Than on 4/21/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellMenu: UICollectionViewCell{
    
    var modelMenu:Nhomsanpham?{
        didSet{
            
            if let url = modelMenu?.Hinhnhomsanpham {
                iconMenu.LoadImageUrlString(urlString: url)
            }
            
            if let txt = modelMenu?.Tennhomsanpham {
                txtMenu.text = txt
            }
        }
    }
    
    
    let iconMenu:UIImageView = {
        let i = UIImageView(frame: .zero)
        i.layer.masksToBounds = true
        i.clipsToBounds = true
        i.contentMode = .scaleToFill
        return i
    }()
    
    let txtMenu:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/30)
        t.contentMode = .center
        t.textColor = UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
        
        return t
    }()
    
    let duongKe:UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor.black
        return v
    }()
    
    var isRadus:Bool = false
    
    
    override var isSelected: Bool{
        didSet{
            iconMenu.tintColor = isSelected ? UIColor.init(red: 233/255, green: 25/255, blue: 66/255, alpha: 1):UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
            txtMenu.textColor = isSelected ? UIColor.init(red: 233/255, green: 25/255, blue: 66/255, alpha: 1):UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
            
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            iconMenu.tintColor = isSelected ? UIColor.init(red: 233/255, green: 25/255, blue: 66/255, alpha: 1):UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
            txtMenu.textColor = isSelected ? UIColor.init(red: 233/255, green: 25/255, blue: 66/255, alpha: 1):UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(duongKe)
        addSubview(iconMenu)
        
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: duongKe)
        
        addConstraintsArray(withVisualFormat: "H:[v0]", views: iconMenu)
        addConstraintsArray(withVisualFormat: "V:|[v0(1)]-5-[v1]", views: duongKe, iconMenu)
        addSubview(txtMenu)
        addConstraintsArray(withVisualFormat: "H:[v0]", views: txtMenu)
        addConstraintsArray(withVisualFormat: "V:[v0]|", views: txtMenu)
        
        addConstraint(NSLayoutConstraint(item: iconMenu, attribute: .bottom, relatedBy: .equal, toItem: txtMenu, attribute: .top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconMenu, attribute: .bottom, relatedBy: .equal, toItem: txtMenu, attribute: .top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconMenu, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: iconMenu, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.6, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconMenu, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.6, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: txtMenu, attribute: .centerX, relatedBy: .equal, toItem: iconMenu, attribute: .centerX, multiplier: 1, constant: 0))
        
        iconMenu.tintColor = UIColor.init(red: 66/255, green: 67/255, blue: 66/255, alpha: 1)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isRadus {
            iconMenu.layer.cornerRadius = iconMenu.frame.height/2
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
