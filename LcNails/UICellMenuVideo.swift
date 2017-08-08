//
//  UICellMenuVideo.swift
//  LcNails
//
//  Created by Nong Than on 4/21/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellMenuVideo: UICollectionViewCell {

    var modelVideo:Video?{
        didSet{
            if let urlVideo = modelVideo?.Idvideo {
                imgVideo.LoadImageUrlString(urlString: "https://img.youtube.com/vi/\(urlVideo)/maxresdefault.jpg")
            }
        }
    }
    
    
    let imgVideo:UIImageView = {
        let i = UIImageView(frame: .zero)
        i.layer.masksToBounds = true
        i.contentMode = .scaleToFill
        i.clipsToBounds = true
        return i
    }()
    
    let imgPlay:UIImageView = {
        let i = UIImageView(frame: .zero)
        i.layer.masksToBounds = true
        i.contentMode = .scaleToFill
        i.clipsToBounds = true
        i.image = UIImage(named: "replay")
        return i
    }()
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgVideo)
        addSubview(imgPlay)
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: imgVideo)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: imgVideo)
    
        addConstraintsArray(withVisualFormat: "H:[v0]", views: imgPlay)
        addConstraintsArray(withVisualFormat: "V:[v0]", views: imgPlay)
    
    addConstraint(NSLayoutConstraint(item: imgPlay, attribute: .width, relatedBy: .equal, toItem: imgVideo, attribute: .height, multiplier: 0.5, constant: 0))
    addConstraint(NSLayoutConstraint(item: imgPlay, attribute: .height, relatedBy: .equal, toItem: imgVideo, attribute: .height, multiplier: 0.5, constant: 0))
    addConstraint(NSLayoutConstraint(item: imgPlay, attribute: .centerX, relatedBy: .equal, toItem: imgVideo, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: imgPlay, attribute: .centerY, relatedBy: .equal, toItem: imgVideo, attribute: .centerY, multiplier: 1, constant: 0))
    
    
    

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        imgPlay.layer.cornerRadius = imgPlay.frame.height/2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
