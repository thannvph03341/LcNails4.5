//
//  UICellHeader.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellHeader:UICollectionReusableView{
    
    var nhomSanPham:Nhomsanpham?{
        didSet{
            if let ten = nhomSanPham?.Tennhomsanpham {
                txtHeader.text = ten
            }
            
        }
    }
    
    
    var nhomSanPhamCon:ModelNhomSanPhamTheoNhomCha?{
        didSet{
            
            if let ten = nhomSanPhamCon?.tenNhomCon {
                txtHeader.text = ten
            }
        }
    }
    
    var viewXemThemSanPham:XemThemSanPhamDelegate?
    
    let txtHeader:UILabel = {
        let t = UILabel(frame: .zero)
            t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
            t.textColor = UIColor.init(red: 255/255, green: 0/255, blue: 53/255, alpha: 1)
            t.textAlignment = .left
            
        return t
    }()
    
    let txt:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
        t.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 53/255, alpha: 1)
        t.textAlignment = .left
        t.text = "CHA"
        return t
    }()
    
    let btnXemThem:UIButton = {
        let t = UIButton(frame: .zero)
            t.setTitle("Xem Thêm >", for: .normal)
            t.setTitleColor(UIColor.init(red: 0/255, green: 90/255, blue: 255/255, alpha: 1), for: .normal)
            t.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/18)
            return t
    }()
    
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(txtHeader)
        addSubview(btnXemThem)
        addSubview(txt)
    
        addConstraintsArray(withVisualFormat: "H:|-6-[v0]", views: txtHeader)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: txtHeader)
    
        addConstraintsArray(withVisualFormat: "H:[v0(150)]-6-|", views: btnXemThem)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: btnXemThem)
    
    addConstraintsArray(withVisualFormat: "H:[v0(0)]", views: txt)
    addConstraintsArray(withVisualFormat: "V:[v0(0)]", views: txt)
    
        addConstraint(NSLayoutConstraint(item: txtHeader, attribute: .right, relatedBy: .equal, toItem: btnXemThem, attribute: .left, multiplier: 1, constant: 0))
        btnXemThem.addTarget(self, action: #selector(XemThemSanPham), for: .touchUpInside)
    
    }
    
    func XemThemSanPham(){
        
        if txt.text == "CHA" {
            viewXemThemSanPham?.NguoiDungXemSanPhamCungLoaiNhomCha(nhomSanPhamCha: self.nhomSanPham!)
        }
        
        if txt.text == "CON"{
            viewXemThemSanPham?.NguoiDungXemSanPhamCungLoaiNhomCon(nhomCon: self.nhomSanPhamCon!)
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let t = CALayer()
        t.backgroundColor = UIColor.black.cgColor
        t.frame = CGRect(x: 0, y: 0, width:  frame.width, height: 1)
        layer.addSublayer(t)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
