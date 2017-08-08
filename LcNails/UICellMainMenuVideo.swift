//
//  UICellMainMenuVideo.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class UICellMainMenuVideo:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var videoMainMenuDelegate:VideoMainMenuDelegate?
    
    var arrayVideo:[Video]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
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
        addConstraintsArray(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraintsArray(withVisualFormat: "V:|[v0]|", views: collectionView)
        collectionView.register(UICellMenuVideo.self, forCellWithReuseIdentifier: "idCell")
        collectionView.backgroundColor = UIColor.white
        
        
        
        Videos.loadVideo("http://lcnails.vn/api/videoapi") { (videoData) in
            self.arrayVideo = videoData
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let n = arrayVideo?.count {
            return n
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! UICellMenuVideo
            cell.modelVideo = arrayVideo?[indexPath.row]
            cell.layer.masksToBounds = true
            //cell.layer.cornerRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        videoMainMenuDelegate?.NguoiDungChonVideoMenu(videoModel: (arrayVideo?[indexPath.row])!)
        
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
