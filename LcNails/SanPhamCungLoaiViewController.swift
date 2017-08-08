//
//  SanPhamCungLoaiViewController.swift
//  LcNails
//
//  Created by Nong Than on 12/23/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

extension String {
    
    func base64Encoded() -> String {
        let dataUsing = data(using: String.Encoding.utf8)
        let base64String = dataUsing?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    //    func base64Decode() -> String {
    //        let dataUsing = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
    //        let stringDecode = NSString(data: dataUsing! as Data, encoding: String.Encoding.utf8.rawValue)
    //        return stringDecode as! String
    //    }
}



class SanPhamCungLoaiViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    static var showViewHome:HomeView?
    static var idMaNhomSanPham:String?
    static var loadDataNhomCon:Bool = false
    //static var arrSanPhamCungLoai:[ModelSanPham]?
    
    static var cv:UICollectionView?{
        didSet{
            
            if loadDataNhomCon {
                
                ModelSanPham.loadDataOnlineTheoNhomCon(maNhomCon: SanPhamCungLoaiViewController.idMaNhomSanPham!, { (modelSanPham, manhom) in
                    ClassSanphamCungLoai.arrSanPhamCungLoai = modelSanPham
                    ClassSanphamCungLoai.showViewHome = showViewHome
                    SanPhamCungLoaiViewController.cv?.reloadData()
                })
            } else {
                
                ModelSanPham.loadDataOnline(maNhom: SanPhamCungLoaiViewController.idMaNhomSanPham!, { (modelSanPham, manhom) in
                    ClassSanphamCungLoai.arrSanPhamCungLoai = modelSanPham
                    ClassSanphamCungLoai.showViewHome = showViewHome
                    SanPhamCungLoaiViewController.cv?.reloadData()
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SanPhamCungLoaiViewController.cv = nil
        handerclearButton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        collectionView?.alwaysBounceVertical = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = UIColor(red: 230/255, green: 231/255, blue: 233/255, alpha: 1)
        collectionView?.register(ClassSanphamCungLoai.self, forCellWithReuseIdentifier: "cellid")
        collectionView?.isScrollEnabled = false
        textViewSearch.delegate = self
        setupBarButton()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 90)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        //  cell.showViewHome = showViewHome
        
        //cell.backgroundColor = UIColor.blue
        return cell
    }
    
    let textViewSearch:UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.tag = 9999
        
        //tf.layer.borderWidth = 0.5
        // tf.translatesAutoresizingMaskIntoConstraints = true
        tf.backgroundColor = UIColor.white
        return tf
    }()
    
    func iconRightTextFiled(txtFiled:UITextField, nameImage:String) -> UIImageView {
        txtFiled.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 30, width: 30, height: 30))
        let image = UIImage(named: nameImage)
        imageView.image = image
        return imageView
    }
    ///
    func iconLefTextFiled(txtFiled:UITextField, nameImage:String) -> UIImageView {
        txtFiled.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        let image = UIImage(named: nameImage)
        imageView.image = image
        return imageView
    }
    
    func setupBarButton(){
        
        let search_icon = UIImage(named: "search_icon")//?.withRenderingMode(.alwaysOriginal)
        let search_iconButton = UIBarButtonItem(image: search_icon, style: .plain, target: self, action: #selector(handSearch))
        navigationItem.rightBarButtonItems = [search_iconButton]
        
    }
    
    
    
    
    func handerclearButton(){
        let search_icon = UIImage(named: "search_icon")//?.withRenderingMode(.alwaysOriginal)
        let search_iconButton = UIBarButtonItem(image: search_icon, style: .plain, target: self, action: #selector(handSearch))
        navigationItem.rightBarButtonItems?.removeAll()
        navigationItem.rightBarButtonItems?  = [search_iconButton]
        if let viewadd = navigationController?.navigationBar.viewWithTag(9999) {
            viewadd.removeFromSuperview()
        }
        
    }
    
    
    func userSearch(){
        
        
        let binaryData:Data? = textViewSearch.text!.data(using: .utf8, allowLossyConversion: false)
        let _ = binaryData?.reduce("", { (acc, byte) -> String in
            acc + String(byte, radix: 2)
        })
        
        
        
        //   print("base64Decode", textViewSearch.text!.base64Decode())
        print("base64Encoded", textViewSearch.text!.base64Encoded())
        ModelSanPham.loadDataTimKiem(TenSanPham: textViewSearch.text!.base64Encoded()) { (modelSanPham, String) in
            ClassSanphamCungLoai.arrSanPhamCungLoai = modelSanPham
            // ClassSanphamCungLoai.setDataSearch = self.textViewSearch.text!
            //SanPhamCungLoaiViewController.cv?.reloadData()
        }
        
    }
    
    
    func handSearch(){
        
        textViewSearch.addTarget(self, action: #selector(userSearch), for: UIControlEvents.editingChanged)
        
        navigationController?.navigationBar.addSubview(textViewSearch)
        textViewSearch.frame = CGRect(x: view.frame.width / 3, y: 7.5, width: view.frame.width / 2, height: 30)
        textViewSearch.layer.borderColor = UIColor(red: 19/255, green: 130/255, blue: 255/255, alpha: 1).cgColor
        textViewSearch.layer.borderWidth = 0.5
        textViewSearch.endEditing(true)
        textViewSearch.leftView = iconLefTextFiled(txtFiled: textViewSearch, nameImage: "")
        let search_clear = UIImage(named: "clearbutton")//?.withRenderingMode(.alwaysOriginal)
        let search_clearButton = UIBarButtonItem(image: search_clear, style: .plain, target: self, action: #selector(handerclearButton))
        navigationItem.rightBarButtonItems?.removeAll()
        navigationItem.rightBarButtonItems = [search_clearButton]
        //        navigationController?.navigationBar.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : textViewSearch]))
        //         navigationController?.navigationBar.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : textViewSearch]))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textViewSearch.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textViewSearch.resignFirstResponder()
        return true
    }
    
}

class ClassSanphamCungLoai:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static var showViewHome:HomeView?
    static var nguoiDungClick:SanPhamDelegate?
    
    
    static var arrSanPhamCungLoai:[ModelSanPham]?{
        didSet {
            collectionviewConfig.reloadData()
        }
    }
    
    static var collectionviewConfig:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ClassSanphamCungLoai.collectionviewConfig)
        ClassSanphamCungLoai.collectionviewConfig.delegate = self
        ClassSanphamCungLoai.collectionviewConfig.dataSource = self
        ClassSanphamCungLoai.collectionviewConfig.delegate = self
        ClassSanphamCungLoai.collectionviewConfig.dataSource = self
        ClassSanphamCungLoai.collectionviewConfig.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 30, 0)
        ClassSanphamCungLoai.collectionviewConfig.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
        ClassSanphamCungLoai.collectionviewConfig.showsVerticalScrollIndicator = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ClassSanphamCungLoai.collectionviewConfig]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ClassSanphamCungLoai.collectionviewConfig]))
        //collectionviewConfig.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        ClassSanphamCungLoai.collectionviewConfig.register(CellSanPham.self, forCellWithReuseIdentifier: "cell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = ClassSanphamCungLoai.arrSanPhamCungLoai?.count {
            return number
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 12, height: 245)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellSanPham
        cell.sanPham = ClassSanphamCungLoai.arrSanPhamCungLoai?[indexPath.item]
        cell.layer.borderColor =  UIColor(white: 0.65, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 1
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ClassSanphamCungLoai.nguoiDungClick?.SanPhamClick(sanPham: (ClassSanphamCungLoai.arrSanPhamCungLoai?[indexPath.item])!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
