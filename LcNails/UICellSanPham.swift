//
//  UICellSanPham.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit
import moa

class UICellSanPham: UICollectionViewCell{

    var modelSanPham:ModelSanPham?{
        didSet{
            let numberFormart = NumberFormatter()
                numberFormart.numberStyle = .decimal
            
            if let urlSanPham = modelSanPham?.Iconimg {
               // imgSanPham.LoadImageUrlString(urlString: urlSanPham)
                imgSanPham.moa.url = urlSanPham
            }
            
            if let ten = modelSanPham?.Tensanpham {
                txtTenSanPham.text = ten
            }
            
            if let dongia = modelSanPham?.Dongia {
                txtGiaSanPham.text = "\(numberFormart.string(from: dongia)!) đ"
            }
            
            if let like = modelSanPham?.SlLike {
                txtLikeSanPham.text = numberFormart.string(from: like)!
            }
        }
    }
    
    
    let imgSanPham:UIImageView = {
        let img = UIImageView(frame: .zero)
            img.contentMode = .scaleToFill
            img.layer.masksToBounds = true
            img.clipsToBounds = true
        return img
    }()
    
    
    let imgLikeSanPham:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "love")
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        return img
    }()
    
    let txtLikeSanPham:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/30)
        t.textColor = UIColor.init(red: 242/255, green: 82/255, blue: 104/255, alpha: 1)
        t.text = "0"
        return t
    }()
    
    let txtGiaSanPham:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
        t.textColor = UIColor.init(red: 242/255, green: 82/255, blue: 104/255, alpha: 1)
        t.text = "10.000 đ"
        return t
    }()
    
    let txtTenSanPham:UILabel = {
        let t = UILabel(frame: .zero)
            t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/25)
            t.textColor = UIColor.black
            t.numberOfLines = 2
        return t
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(imgSanPham)
        addSubview(txtGiaSanPham)
        addSubview(txtLikeSanPham)
        addSubview(imgLikeSanPham)
        addSubview(txtTenSanPham)
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: imgSanPham)
        addConstraintsArray(withVisualFormat: "V:|[v0(\(EnumSizeCell.imgSanPhamSize.getSize()))]", views: imgSanPham)

        addConstraintsArray(withVisualFormat: "H:|-2-[v0(\(frame.width - frame.width/3))][v1(20)]-2-[v2]", views: txtGiaSanPham, imgLikeSanPham, txtLikeSanPham)
        addConstraintsArray(withVisualFormat: "V:[v0(20)]", views: imgLikeSanPham)
        addConstraintsArray(withVisualFormat: "V:[v0(20)]", views: txtGiaSanPham)
        addConstraintsArray(withVisualFormat: "V:[v0(10)]", views: txtLikeSanPham)
        
        addConstraint(NSLayoutConstraint(item: imgLikeSanPham, attribute: .centerY, relatedBy: .equal, toItem: txtGiaSanPham, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: txtLikeSanPham, attribute: .centerY, relatedBy: .equal, toItem: imgLikeSanPham, attribute: .centerY, multiplier: 1, constant: -6))
        
        
        addConstraint(NSLayoutConstraint(item: txtGiaSanPham, attribute: .top, relatedBy: .equal, toItem: imgSanPham, attribute: .bottom, multiplier: 1, constant: 3))
        addConstraintsArray(withVisualFormat: "H:|-2-[v0]-2-|", views: txtTenSanPham)
        addConstraintsArray(withVisualFormat: "V:[v0]", views: txtTenSanPham)
        addConstraint(NSLayoutConstraint(item: txtTenSanPham, attribute: .top, relatedBy: .equal, toItem: txtGiaSanPham, attribute: .bottom, multiplier: 1, constant: 0))
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let t = CALayer()
            t.backgroundColor = UIColor.black.cgColor
            t.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        
        let l = CALayer()
        l.backgroundColor = UIColor.black.cgColor
        l.frame = CGRect(x: 0, y: 0, width: 1, height: frame.height)
        
        let r = CALayer()
        r.backgroundColor = UIColor.black.cgColor
        r.frame = CGRect(x: frame.width - 1, y: 0, width: 1, height: frame.height)
        
//        let b = CALayer()
//        b.backgroundColor = UIColor.black.cgColor
//        b.frame = CGRect(x: 0, y: frame.height - 1, width:  frame.width, height: 1)
        layer.addSublayer(t)
        layer.addSublayer(l)
        //layer.addSublayer(r)
       // layer.addSublayer(b)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
