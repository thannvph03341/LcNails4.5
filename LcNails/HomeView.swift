//
//  HomeView.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow
import Firebase
var arrSlideShowQuangCao:[AFURLSource] = []
var 😂😜😳:[Nhomsanpham] = []

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

class HomeView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,  UIScrollViewDelegate, ViewTopIsScollProduce  {
    
//    var itemClick:String?{
//        didSet{
//            print(itemClick)
//        }
//    }
    //
    let slideShow = ImageSlideshow()
    var IdVideo:String?
    //let navibar = UINavigationBar()
    
    @IBOutlet weak var contronllViewhome: UIView!
    @IBOutlet weak var scrollViewHome: UIScrollView!
    
    @IBOutlet weak var collectionViewBannerMenu: UICollectionView!
    
    var sanpham :[Sanpham]!
    var sanPhamClickGianHang:Sanpham!
    var nhomsanpham :[Nhomsanpham]!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    var cellHeight : CGFloat = 240
    var api : Sanphams!
    var apinhom : Nhomsanphams!
    var video :[Video]!
    var apivideo : Videos!
    var getSlideArray:GetDataSlide!
    var refeshData:UIRefreshControl!
    
    
    let collectionviewStoreSanPham:ViewStoresSanPhamController = {
        let v = ViewStoresSanPhamController()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    func notificationVideo(maVideo:String){
       // print(maVideo)
        IdVideo = maVideo
        //        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        //        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        //        self.present(alert, animated: true, completion: nil)
        performSegue(withIdentifier: "showvideo", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Đăng ký token trên server
        let token = FIRInstanceID.instanceID().token()!
        print("token: \(token)")
        ThongBao.DangKyToken(token: token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contronllViewhome.layer.zPosition = 1
        view.backgroundColor = UIColor(red: 230/255, green: 231/255, blue: 233/255, alpha: 1)
       // view.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        refeshData = UIRefreshControl()
      
        
        /// setup sldie
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeView.didTap))
        
        
        
        
        slideShow.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180)
        slideShow.contentScaleMode = UIViewContentMode.scaleToFill
        slideShow.slideshowInterval = 2
        
        //slide banner
        
        
        //slideBanner.addConstraint(NSLayoutConstraint(item: slideBanner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 8))
        
        slideShow.addGestureRecognizer(gestureRecognizer)
//        navigationController?.navigationBar.barTintColor = UIColor.blue
//        navigationController?.navigationBar.shadowImage = UIImage()
//        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationItem.title = "hehehe"
        navigationController?.navigationBar.isHidden = true
        
        
        scrollViewHome.scrollIndicatorInsets = UIEdgeInsetsMake(-68, 0, -60, 0)
        
        
        scrollViewHome.addSubview(slideShow)
        //scrollViewHome.addSubview(slideBanner)
        scrollViewHome.showsHorizontalScrollIndicator = false
        scrollViewHome.showsVerticalScrollIndicator = false
        
        
        menuCollectionView.showsHorizontalScrollIndicator = false
        collectionViewBannerMenu.showsHorizontalScrollIndicator = false
        
        ///
        collectionViewBannerMenu.delegate = self
        collectionViewBannerMenu.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        //
        
        // scrollViewHome
        refeshData.addTarget(self, action: #selector(HomeView.loadNewData), for: UIControlEvents.valueChanged)
        scrollViewHome.insertSubview(refeshData, at: 0)
        print(scrollViewHome.contentInset)
        
        
        let cellWidth = calcCellWidth(self.view.frame.size) - 8
        cellHeight = cellWidth * 4/3.5
        
        
        self.getSlideArray = GetDataSlide()
        //thu

        GetDataSlide.loadDataSlide("http://lcnails.vn/api/slideapi", completion: didSetDataSlide)
        ///
        self.nhomsanpham = [Nhomsanpham]()
        self.apinhom = Nhomsanphams()
        apinhom.loadNhomsp("http://lcnails.vn/api/Nhomsanphamapi", completion: didLoadNhomsp)
        
        self.video = [Video]()
        self.apivideo = Videos()
        Videos.loadVideo("http://lcnails.vn/api/videoapi", completion: didLoadVideos)
        
        let url = "http://lcnails.vn/api/SanphamApi"
        self.sanpham = [Sanpham]()
        self.api = Sanphams()
        api.loadSanpham(url, completion: didLoadShots)
        
        
        
//        //setup store
        contronllViewhome.addSubview(collectionviewStoreSanPham)
        contronllViewhome.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : collectionviewStoreSanPham]))
        contronllViewhome.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-210-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : collectionviewStoreSanPham]))
//        //
//        // phai co cai nay moi chuyen duoc data tu cac cell ve class Homview
//        
//        
        scrollViewHome.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 180)
       // scrollViewHome.scrollIndicatorInsets =
        collectionviewStoreSanPham.frame = CGRect(x: 0, y: 215, width: view.frame.width, height: view.frame.height)
        
       // contronllViewhome.backgroundColor = UIColor.blue
        
       // contronllViewhome.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 300)
//        ////////////
        ViewStoresSanPhamController.showView = self
        SanPhamViewChiTietController.showView = self
        AppDelegate.showView = self
        ClassViewThongBao.showView = self
        ThongBao.showView = self
        
       

       
        
        // checkVersion
        ClassCheckVersion.getVersion { (bool) in
            if bool {
                let alerDialog:UIAlertController = UIAlertController(title: "Thông báo", message: "Có phiên bản mới bạn vui lòng cập nhật! \nLưu Ý: Bạn bạn nên sử dụng bản mới nhất để có được trải nhiệm tốt nhất!", preferredStyle: .alert)
                let actionUpdate:UIAlertAction = UIAlertAction(title: "Cập nhật", style: .default, handler: { (action) in
                    // print("Duoc")
                    
                    UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/us/app/id1180503098")!)
                })
                alerDialog.addAction(actionUpdate)
                let actionHoiLai:UIAlertAction = UIAlertAction(title: "Hỏi Lại", style: .default, handler: nil)
                alerDialog.addAction(actionHoiLai)
                self.present(alerDialog, animated: true, completion: nil)
            }
        }
        
        ViewStoresSanPhamController.viewTopScoll = self
        
    }
    
    func viewTopScollViewHome() {
        
        scrollViewHome.setContentOffset(CGPoint(x:0, y:slideShow.frame.height + collectionViewBannerMenu.contentSize.height), animated: true)
    }
    
  
    func loadNewData(){
      
       refeshData.endRefreshing()
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
      
    }
    
   
    
    func didLoadVideos(_ loadedShots: [Video]){
        
        for shot in loadedShots {
            self.video.append(shot)
        }
        collectionViewBannerMenu.reloadData()
    }
    
    // cham vao view full anh
    func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
    
    
    
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        if scrollView.contentOffset.y >= -60.0 {
    //
    //            contronllViewhome.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    //            navibar.removeFromSuperview()
    //        }
    //    }
    //
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        if scrollView.contentOffset.y <= -60.0 {
    //            print("hahaah")
    //        }
    //
    //    }
    
    var DinhDangTien: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.isLenient = false
        let loca:NSLocale = NSLocale(localeIdentifier: "vi_VN")
        formatter.locale = loca as Locale!
        //        formatter.currencySymbol = "VND"
        formatter.positiveFormat = "###,###,### đ"
        return formatter
    }
    
    func startViewFolowMaSP(sp:ModelSanPham){
 
//        let donGia = NSDecimalNumber(decimal: sp.Dongia as! Decimal).decimalValue)
        let Gia = self.DinhDangTien.string(from: NSNumber.init(value: Int(sp.Dongia!)))
        
        sanPhamClickGianHang = Sanpham(Dongia: Gia!, Iconimg: sp.Iconimg!, Images: sp.Images!, Masanpham: sp.Masanpham!, Motasanoham: sp.Motasanoham!, Nhomsanpham: sp.Nhomsanpham!, maNhomSanPhamCon: sp.maNhomSanPhamCon!, Tensanpham: sp.Tensanpham!, SpLike: Int(sp.SlLike!))
        performSegue(withIdentifier: "details", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "details"){
            
            // let selectedItems = collectionViewSanPham.indexPathsForSelectedItems
            // if let sItem = selectedItems as [IndexPath]!{
            let shot = self.sanPhamClickGianHang
            let controller = segue.destination as! SanPhamViewChiTietController
            controller.sanpamObject = shot
            //}
            
            
        }
        
        if(segue.identifier == "showvideo"){
            if IdVideo == nil {
                let selectedItems = collectionViewBannerMenu.indexPathsForSelectedItems
                if let sItem = selectedItems as [IndexPath]!{
                    let shot = video[sItem[0].row]
                    let controller = segue.destination as! VideoTableViewController
                    controller.video = shot.Idvideo
                    controller.tenVideoUrl = shot.Tenvideo
                }
            } else {
                // let selectedItems = collectionViewBannerMenu.indexPathsForSelectedItems
                //if let sItem = selectedItems as [IndexPath]!{
                let shot = IdVideo
                IdVideo = nil
                let controller = segue.destination as! VideoTableViewController
                controller.video = shot
                controller.tenVideoUrl = shot
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if collectionView == collectionViewSanPham {
//            performSegue(withIdentifier: "details", sender: self)
//            print("1")
//        }
//        else
            if collectionView == self.collectionViewBannerMenu{
                performSegue(withIdentifier: "showvideo", sender: self)
                print("2")
            } else {
                
                ViewStoresSanPhamController.check = "ConGaBiVatThit"
                ViewStoresSanPhamController.loadNewData(idNhomCha: self.nhomsanpham[indexPath.item].Nhomsanpham1, tenNhom: self.nhomsanpham[indexPath.item].Tennhomsanpham)
        }
    }
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        
        if collectionView == self.menuCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
            let nhomsp = nhomsanpham[indexPath.row]
            cell.menuLabel.text = nhomsp.Tennhomsanpham
//            cell.menuImg.layer.cornerRadius = cell.menuImg.frame.width/2
//            cell.menuImg.layer.masksToBounds = true
            cell.menuImg.image = nil
            Utils.asyncLoadMenuImage(nhomsp, imageView: cell.menuImg)
            return cell
        }
        else if collectionView == self.collectionViewBannerMenu
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBanner", for: indexPath) as! CellBannerHome
            let videoct = video[indexPath.row]
            cell.imageBannerCellHome.image = nil
            cell.imageBannerCellHome.layer.cornerRadius = 5
            cell.imageBannerCellHome.layer.masksToBounds = true
            cell.txtTenVideo.text = videoct.Tenvideo
            Utils.asyncLoadVideoImage(videoct, imageView: cell.imageBannerCellHome)
            return cell
        }
            
        else{
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShotCell", for: indexPath) as! HomeCollectionViewCell
            
            let sanphamct = self.sanpham[indexPath.row]
            
            cell.dongiaLabel.text = sanphamct.Dongia
            cell.tensanphamLabel.text = sanphamct.Tensanpham
            cell.coverImageView.image = nil
            
            cell.like.text =  String (sanphamct.splike).replacingOccurrences(of: ".0", with: "")
            
            Utils.asyncLoadShotImage(sanphamct, imageView: cell.coverImageView)
            //
            cell.layer.borderColor =  UIColor(white: 0.65, alpha: 1.0).cgColor
            cell.layer.cornerRadius = 1
            cell.layer.borderWidth = 1
            return cell
        }
       
        
    }
    
 
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == collectionViewSanPham
//        {
//            //setup độ rộng của scroll theo số item
//            //contronllViewhome.backgroundColor = UIColor.blue
//        if sanpham.count != 0 {
//            
//       
//            
//            collectionView.frame.size = CGSize(width: Int(self.view.frame.width), height: ((sanpham.count * Int(cellHeight))/2) + Int(cellHeight) + 80 + Int(collectionViewBannerMenu.frame.height))
//            
//            scrollViewHome.contentSize = CGSize(width: Int(self.view.frame.width), height: Int(self.collectionViewSanPham.frame.height))
//
//            contronllViewhome.frame = CGRect(x: 0, y: slideShow.frame.height - 40, width: self.view.frame.width, height: collectionViewSanPham.frame.height)
//            
//            //print(contronllViewhome.frame.height,contenScorllView.frame.height)
//        }
//            
//            
//            return sanpham.count
//        }
//        else
        if collectionView == self.collectionViewBannerMenu
        {
            return video.count
        }
        else
        {
            return nhomsanpham.count
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //let cellWidth = calcCellWidth(size)
        //layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    func calcCellWidth(_ size: CGSize) -> CGFloat {
        let transitionToWide = size.width > size.height
        var cellWidth = size.width / 2
        
        if transitionToWide {
            cellWidth = size.width / 3
        }
        
        return cellWidth
    }
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    //    {
    //        let headerView: SectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Sections", for: indexPath) as! SectionView
    //
    //        headerView.nhomSanpham.text = gettGroupLabelAtIndex(indexPath.section)
    //
    //        return headerView
    //    }
    //    func gettGroupLabelAtIndex(_ index: Int) -> String {
    //        return groups[index]
    //    }
    
    
    func didSetDataSlide(_ loadedShots: [SlideModels]) {
        
        for shot in loadedShots {
            arrSlideShowQuangCao.append(AFURLSource(urlString: shot.urlAnh)!)
        }
            slideShow.setImageInputs(arrSlideShowQuangCao)
       
    }
    
    func didLoadNhomsp(_ loadedShots: [Nhomsanpham]){
       
       😂😜😳 = loadedShots
//        for item in 😂😜😳 {
//            ViewStoresSanPhamController().maNhom = item.Nhomsanpham1
//        }
       self.nhomsanpham = loadedShots
       menuCollectionView.reloadData()
    }
    
    
    func didLoadShots(_ loadedShots: [Sanpham]){
      self.sanpham = loadedShots
      //collectionViewSanPham.reloadData()
    }
    
    func didLoadCungLoai(_ loadedShots: [Sanpham]){
        self.sanpham = loadedShots
        //self.collectionViewSanPham.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
          //  self.collectionViewSanPham.reloadData()
        }
        
    }
    
    
 
    
}

