//
//  UICellSlideShow.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow

class UICellSlideShow: UICollectionViewCell{
    
    var rootViewControler:RootViewController?
    
    let slideShow:ImageSlideshow = {
        let i = ImageSlideshow(frame: .zero)
        i.backgroundColor = UIColor.white
        i.contentScaleMode = .scaleToFill
        i.slideshowInterval = 2
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(slideShow)
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: slideShow)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: slideShow)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImageSlide))
        slideShow.addGestureRecognizer(gestureRecognizer)
    }
    
    override func layoutSubviews() {
        
        let a = CALayer()
        a.backgroundColor = UIColor.black.cgColor
        a.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        layer.addSublayer(a)
        
    }
    
    func showImageSlide(){
            rootViewControler?.showImageSlide(slideShow: slideShow)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
