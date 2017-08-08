//
//  UICellNoiBat.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellNoiBat:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var danhSachSanPham:[ModelSanPham]?{
        didSet{
            collectionView.reloadData()
        }
    }

    var handerSanPham:SanPhamDelegate?
    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .vertical
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
            v.showsVerticalScrollIndicator = false
            v.showsHorizontalScrollIndicator = false
            v.dataSource = self
            v.delegate = self
        v.isScrollEnabled = false
        return v
    }()
    
    let idCell:String = "idCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsArray(withVisualFormat: "V:|-1-[v0]-1-|", views: collectionView)
        collectionView.register(UICellSanPham.self, forCellWithReuseIdentifier: idCell)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let n = danhSachSanPham?.count {
            if n < 6 {
                return n
            } else {
                return 6
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if danhSachSanPham != nil {
            if (danhSachSanPham?.count)! > 6 {
                return CGSize(width: (frame.width / 3), height: (frame.height/2) )
            } else {
                return CGSize(width: (frame.width / 3) , height: frame.height )
            }
        } else {
            return CGSize(width: (frame.width / 3), height: frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! UICellSanPham
            cell.modelSanPham = danhSachSanPham?[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handerSanPham?.SanPhamClick(sanPham: (danhSachSanPham?[indexPath.row])!)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
