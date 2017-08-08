//
//  ViewStoresSanPhamController.swift
//  LcNails
//
//  Created by Nong Than on 12/21/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
class ViewStoresSanPhamController:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    static var showView:HomeView?
    // var modelSanPham:ModelSanPham?
    static var arrSanPhamCacGianHang:[Int:[ModelSanPham]]?
    
    static var maNhomTenNhom = [Int:String]()
    static var maNhom = [Int:String]()
    static var check:String = "ConGa"
    //var maNhomLoadXong:String?
    static var nhomSanPham:[ModelNhomSanPham]?
    static var viewTopScoll:ViewTopIsScollProduce?
    
   static let collectionviewStoreSanPham:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            //layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        ModelNhomSanPham.loadNhomSanPham { (nhomSP) in
            ViewStoresSanPhamController.nhomSanPham = nhomSP
            ViewStoresSanPhamController.arrSanPhamCacGianHang = [Int:[ModelSanPham]]()
            var i = 0
            for item in ViewStoresSanPhamController.nhomSanPham! {
                
                ModelSanPham.loadDataOnline(maNhom: item.Nhomsanpham1!) { (arrSanPhamCacGianHangs, maNhom) in
                    ViewStoresSanPhamController.maNhomTenNhom[i] = item.Tennhomsanpham
                    ViewStoresSanPhamController.maNhom[i] = maNhom
                    ViewStoresSanPhamController.arrSanPhamCacGianHang?[i] = arrSanPhamCacGianHangs
                    i += 1
                  //  print(i)
                    ViewStoresSanPhamController.collectionviewStoreSanPham.reloadData()
                }
            }
        }
 
         setupView()
    }

    
    static func loadNewData(idNhomCha:String, tenNhom:String) {
        
        print(idNhomCha)
        var modelNhomSanPhamTheoNhomCha = [ModelNhomSanPhamTheoNhomCha]()
        
        ModelNhomSanPhamTheoNhomCha.loadNhomConTheoNhomCha(idNhomCha: idNhomCha) { (modelNhomSanPhamTheoNhomChas) in
            //print(idNhomCha)
            modelNhomSanPhamTheoNhomCha = modelNhomSanPhamTheoNhomChas
            ViewStoresSanPhamController.arrSanPhamCacGianHang = [Int:[ModelSanPham]]()
            var i = 0
            for item in modelNhomSanPhamTheoNhomCha {
                
                ModelSanPham.loadDataOnlineTheoNhomCon(maNhomCon: item.maNhomSanPhamCon!) { (arrSanPhamCacGianHangs, maNhom) in
                    ViewStoresSanPhamController.maNhomTenNhom[i] = item.tenNhomCon!
                    ViewStoresSanPhamController.maNhom[i] = maNhom
                    ViewStoresSanPhamController.arrSanPhamCacGianHang?[i] = arrSanPhamCacGianHangs
                    i += 1
                    //  print(i)
                    ViewStoresSanPhamController.collectionviewStoreSanPham.reloadData()
                }
            }
        }
        
    }
    
    
    func  setupView() {
        
        addSubview(ViewStoresSanPhamController.collectionviewStoreSanPham)
        ViewStoresSanPhamController.collectionviewStoreSanPham.dataSource = self
        ViewStoresSanPhamController.collectionviewStoreSanPham.delegate = self
       // collectionviewStoreSanPham.showsVerticalScrollIndicator = false
        
        ViewStoresSanPhamController.collectionviewStoreSanPham.contentInset = UIEdgeInsetsMake(0, 0, 5, 0)
        ViewStoresSanPhamController.collectionviewStoreSanPham.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 5, 0)
        ViewStoresSanPhamController.collectionviewStoreSanPham.showsHorizontalScrollIndicator = false
        ViewStoresSanPhamController.collectionviewStoreSanPham.register(CellSanPhamStore.self, forCellWithReuseIdentifier: "cellID")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ViewStoresSanPhamController.collectionviewStoreSanPham]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ViewStoresSanPhamController.collectionviewStoreSanPham]))
       
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y < 0 {
            //print("UP")
            ViewStoresSanPhamController.viewTopScoll?.viewTopScollViewHome()
        //}
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = ViewStoresSanPhamController.arrSanPhamCacGianHang?.count {
            return number
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CellSanPhamStore
           // print(ViewStoresSanPhamController.arrSanPhamCacGianHang?[indexPath.item][0].maNhomSanPhamCon)
            cell.title = ViewStoresSanPhamController.maNhomTenNhom[indexPath.item]
            cell.textMaTheLoai = ViewStoresSanPhamController.maNhom[indexPath.item]
            cell.arrSanPhamTrongGian = ViewStoresSanPhamController.arrSanPhamCacGianHang?[indexPath.item]
            cell.showView = ViewStoresSanPhamController.showView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // print(UIScreen.main.bounds.height)
       // print(frame)
        /// looi :)))
        ViewStoresSanPhamController.collectionviewStoreSanPham.frame = CGRect(x: 0, y: 0, width: frame.width, height: UIScreen.main.bounds.height - 160)
        ViewStoresSanPhamController.collectionviewStoreSanPham.contentSize = CGSize(width: frame.width, height: UIScreen.main.bounds.height - 160)
        ViewStoresSanPhamController.collectionviewStoreSanPham.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, UIScreen.main.bounds.height - 160, 0)
        return CGSize(width: frame.width, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CellSanPhamStore: UICollectionViewCell,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FunctionProtocol{
    
    var showView:HomeView?
    
  var arrSanPhamTrongGian:[ModelSanPham]?{
        didSet{
            collectionViewCellSanPhamStore.reloadData()
        }
    }
    
    
    var title:String?{
        didSet{
            titleTheLoai.text = title!
        }
    }
    
    var textMaTheLoai:String? {
        didSet{
            txtMaTheLoai.text = textMaTheLoai!
        }
    }
    
    let collectionViewCellSanPhamStore:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionViewCellSanPhamStore.delegate = self
        collectionViewCellSanPhamStore.dataSource = self
        collectionViewCellSanPhamStore.showsHorizontalScrollIndicator = false
        collectionViewCellSanPhamStore.showsVerticalScrollIndicator = false
        
       collectionViewCellSanPhamStore.register(CellSanPham.self, forCellWithReuseIdentifier: "cellId")
        setupView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = arrSanPhamTrongGian?.count {
            return number
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CellSanPham
        
        btnXemThem.addTarget(self, action: #selector(XemThem), for: UIControlEvents.touchUpInside)
            cell.sanPham = arrSanPhamTrongGian?[indexPath.item]
           // cell.layer.cornerRadius = 10
            //cell.layer.masksToBounds = true
        cell.layer.borderColor =  UIColor(white: 0.65, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 1
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.white
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: frame.height - 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //if let id = arrSanPhamTrongGian?[indexPath.item].Makhachhang! {
        showView?.startViewFolowMaSP(sp: (arrSanPhamTrongGian?[indexPath.item])!)
        SanPhamViewChiTietController.nguoiDunglike = self
       // }
       
    }
    
    
   
    //
    let titleTheLoai:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Dụng Cụ"
        lb.textColor = UIColor.black
        lb.backgroundColor = UIColor.clear
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    
    let btnXemThem:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Xem Thêm", for: UIControlState.normal)
    
        btn.setTitleColor(UIColor(red: 5/255, green: 128/255, blue: 255/255, alpha: 1), for: UIControlState.normal)
        btn.backgroundColor = UIColor.clear
        return btn
    }()
    
    let txtMaTheLoai:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "tl"
        lb.textColor = UIColor.black
        lb.backgroundColor = UIColor.clear
        lb.font = UIFont.systemFont(ofSize: 0)
        return lb
    }()
    
    ///
    let header:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
       v.backgroundColor = UIColor.clear
        return v
    }()
    
    func setupView(){
        
        addSubview(collectionViewCellSanPhamStore)
        addSubview(header)
        header.addSubview(titleTheLoai)
        header.addSubview(btnXemThem)
        header.addSubview(txtMaTheLoai)
        //collectionViewCellSanPhamStore.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 5, 0)
         //collectionViewCellSanPhamStore.contentInset = UIEdgeInsetsMake(0, 0, 5, 0)
       // btnXemThem.frame.origin.y = 10
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : collectionViewCellSanPhamStore]))
       // collectionViewCellSanPhamStore.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : header]))
                                                                        //|-(-30)-[header(30)][v0]|
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[header][v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["header":header,"v0" : collectionViewCellSanPhamStore]))
       header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : titleTheLoai]))
         header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : titleTheLoai]))
        

        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(\(UIScreen.main.bounds.width / 3))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : btnXemThem]))
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : btnXemThem]))
        
        if UIScreen.main.bounds.width < 400 {
            header.addConstraint(NSLayoutConstraint(item: btnXemThem, attribute: .left, relatedBy: .equal, toItem: titleTheLoai, attribute: .right, multiplier: 1, constant: (UIScreen.main.bounds.width / 1.9) - (UIScreen.main.bounds.width / 5)))
        } else {
            header.addConstraint(NSLayoutConstraint(item: btnXemThem, attribute: .left, relatedBy: .equal, toItem: titleTheLoai, attribute: .right, multiplier: 1, constant: (UIScreen.main.bounds.width / 1.9) - (UIScreen.main.bounds.width / 8)))
        }
    }
    
    func XemThem(){
        let layout = UICollectionViewFlowLayout()
        let viewController = SanPhamCungLoaiViewController(collectionViewLayout: layout)
        SanPhamCungLoaiViewController.idMaNhomSanPham = txtMaTheLoai.text!
        print(txtMaTheLoai.text!)
        SanPhamCungLoaiViewController.showViewHome = showView
        showView?.navigationController?.pushViewController(viewController, animated: true)
       // print(txtMaTheLoai.text!)
    }
    
    
    func NguoiDungThichSanPham(maSanPham: String, soLuotLike: Int) {
        for item in arrSanPhamTrongGian! {
            if item.Masanpham?.trimmingCharacters(in: .whitespaces) == maSanPham {
                item.SlLike = soLuotLike as NSNumber?
            }
        }
        
        collectionViewCellSanPhamStore.reloadData()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

import moa
class CellSanPham:UICollectionViewCell {
    
    var sanPham:ModelSanPham?{
        didSet{
            let numbetFomat = NumberFormatter()
            numbetFomat.numberStyle = .decimal
            if let gia = sanPham?.Dongia {
                txtGia.text = "\(numbetFomat.string(from: gia)!) đ"
            }
            
            if let ten = sanPham?.Tensanpham {
                txtTenSanPham.text = ten
            }
            
            if let like = sanPham?.SlLike {
                txtLike.text = numbetFomat.string(from: like)!
            }
            
            if let imgsp = sanPham?.Iconimg {
                //imageSanPham.LoadImageUrlString(urlString: imgsp)
                    imageSanPham.moa.url = imgsp
            }
        }
    }
    

    override var isSelected: Bool{
        didSet{
            //txtLike.textColor = isSelected ? UIColor.red: UIColor.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let imageSanPham:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo_1")
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
       // img.clipsToBounds = true
        return img
    }()
    
    let txtGia:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.red
        lb.text = "0 đ"
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    let txtTenSanPham:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.black
        lb.backgroundColor = UIColor.clear
        lb.text = "San pham aa"
        return lb
    }()
    
    let txtLike:UITextView = {
        let lb = UITextView()
        lb.textContainerInset = UIEdgeInsetsMake(-1, -2, 0, 0)
        lb.isEditable = false
        lb.isSelectable = false
        lb.font = UIFont.systemFont(ofSize: 10)
        lb.textColor = UIColor.black
        lb.backgroundColor = UIColor.clear
        lb.text = "0"
        return lb
    }()
    
    let imgLike:UIImageView = {
        let img = UIImageView() 
        img.image = UIImage(named: "like_flat")
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        return img
    }()
    
    
    
    func setupView(){
        addSubview(imageSanPham)
        addSubview(txtGia)
        addSubview(txtTenSanPham)
        addSubview(imgLike)
        addSubview(txtLike)
        imageSanPham.frame = CGRect(x: 0, y: 0, width: frame.width, height: 190)
        txtGia.frame = CGRect(x: 5, y: 192, width: frame.width / 1.6, height: 20)
        txtTenSanPham.frame = CGRect(x: 5, y: 212, width: frame.width - 5, height: 20)
        imgLike.frame = CGRect(x: (frame.width / 1.6) + 6, y: 192, width: 20, height: 20)
        txtLike.frame = CGRect(x: (frame.width / 1.6) + 26, y: 192, width: 40, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModelNhomSanPhamTheoNhomCha:NSObject {

    var stt:NSNumber?
    var maNhomSanPhamCon:String?
    var tenNhomCon:String?
    var Nhomsanpham:String?
    var HinhnhomsanphamCon:String?
    
    static func loadNhomConTheoNhomCha(idNhomCha:String, complite: @escaping ([ModelNhomSanPhamTheoNhomCha]) -> Void ){
        let url = "http://lcnails.vn/api/NhomsanphamConApi?idNhomCha=\(idNhomCha.trimmingCharacters(in: .whitespaces))".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        URLSession.shared.dataTask(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (data, respones, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let Json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                var arrNhomConTheoNhomCha = [ModelNhomSanPhamTheoNhomCha]()
                for item in Json as! [[String:AnyObject]] {
                    let modelNhomCon = ModelNhomSanPhamTheoNhomCha()
                    
                    if let stt = item["stt"] as? NSNumber {
                        modelNhomCon.stt = stt
                    } else {
                         modelNhomCon.stt = -1
                    }
                    
                    if let maNhomSanPhamCon = item["maNhomSanPhamCon"] as? String {
                        modelNhomCon.maNhomSanPhamCon = maNhomSanPhamCon
                    } else {
                        modelNhomCon.maNhomSanPhamCon = ""
                    }
                    
                    if let tenNhomCon = item["tenNhomCon"] as? String {
                        modelNhomCon.tenNhomCon = tenNhomCon
                    } else {
                        modelNhomCon.tenNhomCon = ""
                    }
                    
                    if let Nhomsanpham = item["Nhomsanpham"] as? String {
                        modelNhomCon.Nhomsanpham = Nhomsanpham
                    } else {
                        modelNhomCon.Nhomsanpham = ""
                    }
                    
                    if let HinhnhomsanphamCon = item["HinhnhomsanphamCon"] as? String {
                        modelNhomCon.HinhnhomsanphamCon = HinhnhomsanphamCon
                    } else {
                        modelNhomCon.HinhnhomsanphamCon = ""
                    }
                    ///
                    arrNhomConTheoNhomCha.append(modelNhomCon)
                }
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    complite(arrNhomConTheoNhomCha)
                })
                
            } catch let err {
                print(err)
            }
            
        }.resume()
        
    }
    
}


//
class ModelNhomSanPham:NSObject {
    
    var Nhomsanpham1:String?
    var Tennhomsanpham:String?
    var Hinhnhomsanpham:String?
    var stt:NSNumber?
    
    static func loadNhomSanPham(_ compile: @escaping ([ModelNhomSanPham]) -> Void)  {
        let url = "http://lcnails.vn/api/Nhomsanphamapi"
        var nhomsanpham = [ModelNhomSanPham]()
        URLSession.shared.dataTask(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do
            {
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                for station in json as! [[String: AnyObject]] {
                    
                    //let stringTemp = String(describing: donGia)
                    
                    var Hinhnhomsanpham:String
                    if ((station["Hinhnhomsanpham"] as? String) != nil) {
                        Hinhnhomsanpham = (station["Hinhnhomsanpham"] as? String)!
                    }
                    else { Hinhnhomsanpham="" }
                    
                    var Nhomsanpham1:String
                    if ((station["Nhomsanpham1"] as? String) != nil) {
                        Nhomsanpham1 = (station["Nhomsanpham1"] as? String)!
                    }
                    else { Nhomsanpham1="" }
                    
                    var Tennhomsanpham:String
                    if ((station["Tennhomsanpham"] as? String) != nil) {
                        Tennhomsanpham = (station["Tennhomsanpham"] as? String)!
                    }
                    else { Tennhomsanpham="" }
                    
                    
                    var stt:NSNumber
                    if ((station["stt"] as? NSNumber) != nil) {
                        stt = (station["stt"] as? NSNumber)!
                    }
                    else { stt = 0 }
                    
                    
                    
                    let model = ModelNhomSanPham()
                    model.Nhomsanpham1 = Nhomsanpham1
                    model.Tennhomsanpham = Tennhomsanpham
                    model.Hinhnhomsanpham = Hinhnhomsanpham
                    model.stt = stt
                    
                    nhomsanpham.append(model)
                    
                }
                DispatchQueue.main.sync(execute: { () -> Void in
                    compile(nhomsanpham)
                })
                
            } catch let err {
                print(err)
            }
            
            
            }.resume()
    }

}


class ModelSanPham:NSObject {
    
    var Masanpham:String? //
    var Makhachhang: String? //
    var Nhomsanpham:String? //
    var Tensanpham:String? //
    var Motasanoham:String?
    var Dongia:NSNumber? //
    var Soluong:NSNumber? //
    var Ngaytao:String? //
    var Thutu:NSNumber? //
    var Iconimg:String? //
    var Images:String? //
    var maNhomSanPhamCon:String?
    var SlLike:NSNumber? //
    var Giacu: NSNumber?
    var arrSanPham:[ModelSanPham]?
    var tieuDe:String?
    var noiDung:String?
    
//    override func setValue(_ value: Any?, forKey key: String) {
//       // arrSanPham = [ModelSanPham]()
//        //arrSanPham?.append(value as! ModelSanPham)
//    }
//    
    
    ////Lấyn Phẩm theo notification////
    
    static func loadDataNotifications(manSanPham:String, _ loadXong: @escaping ([ModelSanPham], _ maNhomLoadXong:String) -> Void ){
        var url:String?
        //var arrSanPhamTheoCacGianHang = [String:[ModelSanPham]]()
        var arrSanPhamTrongGianHang = [ModelSanPham]()
        
        for item in manSanPham.components(separatedBy: ";") {
            url = "http://lcnails.vn/TimKiemApiTheoNotification/\(item.trimmingCharacters(in: .whitespaces))"
      
        
        URLSession.shared.dataTask(with: URL(string: (url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if data?.count != 0 {
                
                do {
                    
                    let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    
                    
                    for items in json as! [[String:AnyObject]] {
                      
                            let sanphamMode = ModelSanPham()
                            
                            if let ma = items["Masanpham"] as? String {
                                sanphamMode.Masanpham = ma
                            } else {
                                sanphamMode.Masanpham = ""
                            }
                            
                            
                            if let gia = items["Dongia"] as? NSNumber {
                                sanphamMode.Dongia = gia
                            } else {
                                sanphamMode.Dongia = 0
                            }
                            
                            if let ten = items["Tensanpham"] as? String {
                                sanphamMode.Tensanpham = ten
                            } else {
                                sanphamMode.Tensanpham = ""
                            }
                            
                            if let like = items["SlLike"] as? NSNumber {
                                sanphamMode.SlLike = like
                            } else {
                                sanphamMode.SlLike = 0
                            }
                            
                            if let linkImage = items["Iconimg"] as? String {
                                sanphamMode.Iconimg = linkImage
                            } else {
                                sanphamMode.Iconimg = "http://lcnails.vn/theme/images/logo.png"
                            }
                            
                            if let mkh = items["Makhachhang"] as? String {
                                sanphamMode.Makhachhang = mkh
                            } else {
                                sanphamMode.Makhachhang = ""
                            }
                            
                            if let nhomsp = items["Nhomsanpham"] as? String {
                                sanphamMode.Nhomsanpham = nhomsp
                            } else {
                                sanphamMode.Nhomsanpham = ""
                            }
                            
                            if let sl = items["Soluong"] as? NSNumber {
                                sanphamMode.Soluong = sl
                            } else {
                                sanphamMode.Soluong = 0
                            }
                            
                            if let nt = items["Ngaytao"] as? String {
                                sanphamMode.Ngaytao = nt
                            } else {
                                sanphamMode.Ngaytao = ""
                            }
                            
                            if let Thutu = items["Thutu"] as? NSNumber {
                                sanphamMode.Thutu = Thutu
                            } else {
                                sanphamMode.Thutu = 0
                            }
                            
                            if let Images = items["Images"] as? String {
                                sanphamMode.Images = Images
                            } else {
                                sanphamMode.Images = ""
                            }
                            
                            if let maNhomSanPhamCon = items["maNhomSanPhamCon"] as? String {
                                sanphamMode.maNhomSanPhamCon = maNhomSanPhamCon
                            } else {
                                sanphamMode.maNhomSanPhamCon = ""
                            }
                            
                            if let Giacu = items["Giacu"] as? NSNumber {
                                sanphamMode.Giacu = Giacu
                            } else {
                                sanphamMode.Giacu = 0
                            }
                            //
                            if let Motasanoham = items["Motasanoham"] as? String {
                                sanphamMode.Motasanoham = Motasanoham
                            } else {
                                sanphamMode.Motasanoham = ""
                            }
                            
                            
                            arrSanPhamTrongGianHang.append(sanphamMode)
                        
                        
                    }
                    
                    //arrSanPhamTheoCacGianHang[maNhom] = arrSanPhamTrongGianHang
                    let nhomLoad = manSanPham
                    DispatchQueue.main.sync(execute: { () -> Void in
                        loadXong(arrSanPhamTrongGianHang, nhomLoad)
                    })
                    
                }catch let err {
                    print("josn err:", err)
                }
            }
            }.resume()
        }
    }

    
    
    
    
    ////Tim Kiem////
    
    static func loadDataTimKiem(TenSanPham:String, _ loadXong: @escaping ([ModelSanPham], _ maNhomLoadXong:String) -> Void ){
        let url:String!
        if TenSanPham == "" {
             url = "http://lcnails.vn/api/SanphamApi"
        } else {
   
            if TenSanPham.trimmingCharacters(in: .whitespaces).substring(from: TenSanPham.trimmingCharacters(in: .whitespaces).index(TenSanPham.trimmingCharacters(in: .whitespaces).endIndex, offsetBy: -2)) == "==" {
                url = "http://lcnails.vn/api/timkiemapi/?txtTimKiem=\(TenSanPham.trimmingCharacters(in: .whitespaces))"
                print("vao: ==")
            } else if TenSanPham.trimmingCharacters(in: .whitespaces).substring(from: TenSanPham.trimmingCharacters(in: .whitespaces).index(TenSanPham.trimmingCharacters(in: .whitespaces).endIndex, offsetBy: -1)) == "=" {
                print("vao: =")
                 url = "http://lcnails.vn/api/timkiemapi/?txtTimKiem=\(TenSanPham.trimmingCharacters(in: .whitespaces))="
            } else {
                 print("vao: nil")
                url = "http://lcnails.vn/api/timkiemapi/?txtTimKiem=\(TenSanPham.trimmingCharacters(in: .whitespaces))"
                
            }
            
        }
        
        URLSession.shared.dataTask(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            
            do {
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                //var arrSanPhamTheoCacGianHang = [String:[ModelSanPham]]()
                var arrSanPhamTrongGianHang = [ModelSanPham]()
                
                for items in json as! [[String:AnyObject]] {
                    
                    let sanphamMode = ModelSanPham()
                    
                    if let ma = items["Masanpham"] as? String {
                        sanphamMode.Masanpham = ma
                    } else {
                        sanphamMode.Masanpham = ""
                    }
                    
                    
                    if let gia = items["Dongia"] as? NSNumber {
                        sanphamMode.Dongia = gia
                    } else {
                        sanphamMode.Dongia = 0
                    }
                    
                    if let ten = items["Tensanpham"] as? String {
                        sanphamMode.Tensanpham = ten
                    } else {
                        sanphamMode.Tensanpham = ""
                    }
                    
                    if let like = items["SlLike"] as? NSNumber {
                        sanphamMode.SlLike = like
                    } else {
                        sanphamMode.SlLike = 0
                    }
                    
                    if let linkImage = items["Iconimg"] as? String {
                        sanphamMode.Iconimg = linkImage
                    } else {
                        sanphamMode.Iconimg = "http://lcnails.vn/theme/images/logo.png"
                    }
                    
                    if let mkh = items["Makhachhang"] as? String {
                        sanphamMode.Makhachhang = mkh
                    } else {
                        sanphamMode.Makhachhang = ""
                    }
                    
                    if let nhomsp = items["Nhomsanpham"] as? String {
                        sanphamMode.Nhomsanpham = nhomsp
                    } else {
                        sanphamMode.Nhomsanpham = ""
                    }
                    
                    if let sl = items["Soluong"] as? NSNumber {
                        sanphamMode.Soluong = sl
                    } else {
                        sanphamMode.Soluong = 0
                    }
                    
                    if let nt = items["Ngaytao"] as? String {
                        sanphamMode.Ngaytao = nt
                    } else {
                        sanphamMode.Ngaytao = ""
                    }
                    
                    if let Thutu = items["Thutu"] as? NSNumber {
                        sanphamMode.Thutu = Thutu
                    } else {
                        sanphamMode.Thutu = 0
                    }
                    
                    if let Images = items["Images"] as? String {
                        sanphamMode.Images = Images
                    } else {
                        sanphamMode.Images = ""
                    }
                    
                    if let maNhomSanPhamCon = items["maNhomSanPhamCon"] as? String {
                        sanphamMode.maNhomSanPhamCon = maNhomSanPhamCon
                    } else {
                        sanphamMode.maNhomSanPhamCon = ""
                    }
                    
                    if let Giacu = items["Giacu"] as? NSNumber {
                        sanphamMode.Giacu = Giacu
                    } else {
                        sanphamMode.Giacu = 0
                    }
                    //
                    if let Motasanoham = items["Motasanoham"] as? String {
                        sanphamMode.Motasanoham = Motasanoham
                    } else {
                        sanphamMode.Motasanoham = ""
                    }
                    
                    
                    arrSanPhamTrongGianHang.append(sanphamMode)
                    
                    
                }
                
                //arrSanPhamTheoCacGianHang[maNhom] = arrSanPhamTrongGianHang
                let nhomLoad = TenSanPham
                DispatchQueue.main.sync(execute: { () -> Void in
                    loadXong(arrSanPhamTrongGianHang, nhomLoad)
                })
                
            }catch let err {
                print("josn err:", err)
            }
            
            }.resume()
    }

    
    ///////
    static func loadDataOnlineTheoNhomCon(maNhomCon:String, _ loadXong: @escaping ([ModelSanPham], _ maNhomLoadXong:String) -> Void ){
        let url = "http://lcnails.vn/api/sanphamapi/?idNhomCon=\(maNhomCon.trimmingCharacters(in: .whitespaces))"
        URLSession.shared.dataTask(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            
            do {
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                //var arrSanPhamTheoCacGianHang = [String:[ModelSanPham]]()
                var arrSanPhamTrongGianHang = [ModelSanPham]()
                
                for items in json as! [[String:AnyObject]] {
                    
                    let sanphamMode = ModelSanPham()
                    
                    if let ma = items["Masanpham"] as? String {
                        sanphamMode.Masanpham = ma
                    } else {
                        sanphamMode.Masanpham = ""
                    }
                    
                    
                    if let gia = items["Dongia"] as? NSNumber {
                        sanphamMode.Dongia = gia
                    } else {
                        sanphamMode.Dongia = 0
                    }
                    
                    if let ten = items["Tensanpham"] as? String {
                        sanphamMode.Tensanpham = ten
                    } else {
                        sanphamMode.Tensanpham = ""
                    }
                    
                    if let like = items["SlLike"] as? NSNumber {
                        sanphamMode.SlLike = like
                    } else {
                        sanphamMode.SlLike = 0
                    }
                    
                    if let linkImage = items["Iconimg"] as? String {
                        sanphamMode.Iconimg = linkImage
                    } else {
                        sanphamMode.Iconimg = "http://lcnails.vn/theme/images/logo.png"
                    }
                    
                    if let mkh = items["Makhachhang"] as? String {
                        sanphamMode.Makhachhang = mkh
                    } else {
                        sanphamMode.Makhachhang = ""
                    }
                    
                    if let nhomsp = items["Nhomsanpham"] as? String {
                        sanphamMode.Nhomsanpham = nhomsp
                    } else {
                        sanphamMode.Nhomsanpham = ""
                    }
                    
                    if let sl = items["Soluong"] as? NSNumber {
                        sanphamMode.Soluong = sl
                    } else {
                        sanphamMode.Soluong = 0
                    }
                    
                    if let nt = items["Ngaytao"] as? String {
                        sanphamMode.Ngaytao = nt
                    } else {
                        sanphamMode.Ngaytao = ""
                    }
                    
                    if let Thutu = items["Thutu"] as? NSNumber {
                        sanphamMode.Thutu = Thutu
                    } else {
                        sanphamMode.Thutu = 0
                    }
                    
                    if let Images = items["Images"] as? String {
                        sanphamMode.Images = Images
                    } else {
                        sanphamMode.Images = ""
                    }
                    
                    if let maNhomSanPhamCon = items["maNhomSanPhamCon"] as? String {
                        sanphamMode.maNhomSanPhamCon = maNhomSanPhamCon
                    } else {
                        sanphamMode.maNhomSanPhamCon = ""
                    }
                    
                    if let Giacu = items["Giacu"] as? NSNumber {
                        sanphamMode.Giacu = Giacu
                    } else {
                        sanphamMode.Giacu = 0
                    }
                    //
                    if let Motasanoham = items["Motasanoham"] as? String {
                        sanphamMode.Motasanoham = Motasanoham
                    } else {
                        sanphamMode.Motasanoham = ""
                    }
                    
                    
                    arrSanPhamTrongGianHang.append(sanphamMode)
                    
                    
                }
                
                //arrSanPhamTheoCacGianHang[maNhom] = arrSanPhamTrongGianHang
                let nhomLoad = maNhomCon
                DispatchQueue.main.sync(execute: { () -> Void in
                    loadXong(arrSanPhamTrongGianHang, nhomLoad)
                })
                
            }catch let err {
                print("josn err:", err)
            }
            
            }.resume()
    }

    
    
    
    
//
    
    static func loadDataOnline(maNhom:String, _ loadXong: @escaping ([ModelSanPham], _ maNhomLoadXong:String) -> Void ){
        let url = "http://lcnails.vn/api/sanphamapi/?idNhom=\(maNhom.trimmingCharacters(in: .whitespaces))"
        URLSession.shared.dataTask(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
           
            do {
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
              
                 //var arrSanPhamTheoCacGianHang = [String:[ModelSanPham]]()
                var arrSanPhamTrongGianHang = [ModelSanPham]()
                
                for items in json as! [[String:AnyObject]] {
                   
                    let sanphamMode = ModelSanPham()
                    
                    if let ma = items["Masanpham"] as? String {
                        sanphamMode.Masanpham = ma
                    } else {
                        sanphamMode.Masanpham = ""
                    }
                    
                    
                    if let gia = items["Dongia"] as? NSNumber {
                        sanphamMode.Dongia = gia
                    } else {
                         sanphamMode.Dongia = 0
                    }
                    
                    if let ten = items["Tensanpham"] as? String {
                        sanphamMode.Tensanpham = ten
                    } else {
                        sanphamMode.Tensanpham = ""
                    }
                    
                    if let like = items["SlLike"] as? NSNumber {
                        sanphamMode.SlLike = like
                    } else {
                         sanphamMode.SlLike = 0
                    }
                    
                    if let linkImage = items["Iconimg"] as? String {
                        sanphamMode.Iconimg = linkImage
                    } else {
                        sanphamMode.Iconimg = "http://lcnails.vn/theme/images/logo.png"
                    }
                    
                    if let mkh = items["Makhachhang"] as? String {
                        sanphamMode.Makhachhang = mkh
                    } else {
                        sanphamMode.Makhachhang = ""
                    }
                    
                    if let nhomsp = items["Nhomsanpham"] as? String {
                        sanphamMode.Nhomsanpham = nhomsp
                    } else {
                        sanphamMode.Nhomsanpham = ""
                    }
                    
                    if let sl = items["Soluong"] as? NSNumber {
                        sanphamMode.Soluong = sl
                    } else {
                        sanphamMode.Soluong = 0
                    }
                    
                    if let nt = items["Ngaytao"] as? String {
                        sanphamMode.Ngaytao = nt
                    } else {
                        sanphamMode.Ngaytao = ""
                    }
                    
                    if let Thutu = items["Thutu"] as? NSNumber {
                        sanphamMode.Thutu = Thutu
                    } else {
                        sanphamMode.Thutu = 0
                    }
                    
                    if let Images = items["Images"] as? String {
                        sanphamMode.Images = Images
                    } else {
                        sanphamMode.Images = ""
                    }
                    
                    if let maNhomSanPhamCon = items["maNhomSanPhamCon"] as? String {
                        sanphamMode.maNhomSanPhamCon = maNhomSanPhamCon
                    } else {
                        sanphamMode.maNhomSanPhamCon = ""
                    }
                    
                    if let Giacu = items["Giacu"] as? NSNumber {
                        sanphamMode.Giacu = Giacu
                    } else {
                        sanphamMode.Giacu = 0
                    }
                    //
                    if let Motasanoham = items["Motasanoham"] as? String {
                        sanphamMode.Motasanoham = Motasanoham
                    } else {
                        sanphamMode.Motasanoham = ""
                    }
                    
                    
                    arrSanPhamTrongGianHang.append(sanphamMode)
                    

                }
                
                //arrSanPhamTheoCacGianHang[maNhom] = arrSanPhamTrongGianHang
                let nhomLoad = maNhom
                DispatchQueue.main.sync(execute: { () -> Void in
                    loadXong(arrSanPhamTrongGianHang, nhomLoad)
                })
               
            }catch let err {
                print("josn err:", err)
            }
            
        }.resume()
    }
    
    static func setUpdata() -> [ModelSanPham]{
        var arrSanPhamTheoCacGianHang = [String:[ModelSanPham]]()
        var arrSanPhamTrongGianHang = [ModelSanPham]()
        let sanpham = ModelSanPham()
        sanpham.Masanpham = "MASP"
        sanpham.Makhachhang = "KH"
        sanpham.Nhomsanpham = "Cat"
        sanpham.Tensanpham = "San Pham Moi"
        sanpham.Dongia = NSNumber(value: 10000)
        sanpham.SlLike = NSNumber(value: 12)
        
        let sanpham1 = ModelSanPham()
        sanpham1.Masanpham = "MA222SP"
        sanpham1.Makhachhang = "KH3"
        sanpham1.Nhomsanpham = "Cat3"
        sanpham1.Tensanpham = "San Pham 3Moi"
        sanpham1.Dongia = NSNumber(value: 10000)
        sanpham1.SlLike = NSNumber(value: 12)
        var arrSanPhamTrongGianHang1 = [ModelSanPham]()
        arrSanPhamTrongGianHang.append(sanpham)
        arrSanPhamTrongGianHang.append(sanpham)
        arrSanPhamTrongGianHang1.append(sanpham1)
        arrSanPhamTheoCacGianHang["0"] = arrSanPhamTrongGianHang
        arrSanPhamTheoCacGianHang["1"] = arrSanPhamTrongGianHang
        arrSanPhamTheoCacGianHang["2"] = arrSanPhamTrongGianHang1
        
        return arrSanPhamTrongGianHang
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func LoadImageUrlString(urlString:String) {
        //let url =
//        image = nil
//        
//        if let imageCacheLoad =  imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            image = imageCacheLoad
//            return
//        }
        if urlString != ""{
            URLSession.shared.dataTask(with: URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!) { (d, r, e) in
                if e != nil {
                    print("Loi load anh!", e!)
                }
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    let imageLoad = UIImage(data: d!)
                    //                imageCache.setObject(imageLoad!, forKey: urlString as AnyObject)
                    self.image = imageLoad
                })
                
                }.resume()
        }
    }
}
