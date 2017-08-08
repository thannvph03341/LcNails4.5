//
//  LoadImageVideoCollectionViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/27/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit


//private let reuseIdentifier = "Cell"
let screen:CGRect = UIScreen.main.bounds

class LoadImageVideoCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
    
        //self.collectionView?.itemSe = CGSize(width: 10, height: 10)
        //self.collectionView.inset
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }


    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionView", for: indexPath) as! ImageVideoCollectionViewCell
    
        cell.txtTenVideo.text = "Tên video"
        
        cell.imageVideo.layer.borderColor = UIColor.black.cgColor
        cell.imageVideo.layer.borderWidth = 0.5
        cell.imageVideo.layer.cornerRadius = 5
       // cell.selectio = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        print(cell.alignmentRectInsets)
        
        //cell.frame.size = CGSize(width: screen.width / 2, height: screen.height/3)
       
       // cell.layer.ins
        //cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
      //  cell.imageVideo.frame.size = CGSize(width: screen.width / 2.2, height: screen.height/2.5)
            //CGRect(0, cell.frame.origin.y, cell.superview!.frame.size.width, cell.frame.size.height)
        cell.imageVideo.image = UIImage(named: "logo_1.png")
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
