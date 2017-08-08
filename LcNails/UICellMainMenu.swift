//
//  UICellMainMenu.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellMainMenu:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var arrMenu:[Nhomsanpham]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var indexCheck:Int = -1
    
    var hander:NguoiDungChonMenuNhomSanPhamDelegate?
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: collectionView)
        collectionView.register(UICellMenu.self, forCellWithReuseIdentifier: "idCell")
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let n = arrMenu?.count {
            return n
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! UICellMenu
            cell.modelMenu = arrMenu?[indexPath.row]
            cell.isRadus = true
        if indexCheck > -1 {
            self.collectionView.selectItem(at: NSIndexPath(row: indexCheck, section: 0) as IndexPath, animated: true, scrollPosition: .top)
        }
        
        let r = CALayer()
            r.frame = CGRect(x: 0, y: 0, width: 1, height: frame.height)
            r.backgroundColor = UIColor.init(red: 40/255, green: 40/255, blue: 40/255, alpha: 1).cgColor
         //   cell.layer.addSublayer(r)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hander?.NguoiDungChonMenuNhomSan(modelNhomSanPham: (arrMenu?[indexPath.row])!, colectionMenu: [indexPath.row:self.collectionView])
        indexCheck = indexPath.row
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/5, height: frame.height)
    }
 
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

