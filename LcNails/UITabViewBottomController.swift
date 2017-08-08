//
//  UITabViewBottomController.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UITabViewBottomController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var delegateTabSelector:TabMenuSelector?
    
    let idCellMenu = "idCellMenu"
    let imageMenu:[String] = ["pethouse", "video_new","shoppingcart","bellx","thongTin"]
    let textMenu:[String] = ["Trang Chủ", "Video","Giỏ Hàng","Thông Báo","Thông Tin"]
    
    override func viewDidLoad() {
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICellMenuTab.self, forCellWithReuseIdentifier: idCellMenu)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageMenu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellMenu, for: indexPath) as! UICellMenuTab
       
            cell.iconMenu.image = UIImage(named: imageMenu[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        
            cell.txtMenu.text = textMenu[indexPath.row]
        return cell
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView?.selectItem(at: NSIndexPath(row: 0, section: 0) as IndexPath, animated: true, scrollPosition: .top)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / CGFloat(imageMenu.count), height: 50)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateTabSelector?.IndexTabSelector(index: indexPath.row)
    }
    
}
