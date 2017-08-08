//
//  RootViewController.swift
//  LcNails
//
//  Created by Nong Than on 4/20/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow


class RootViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, SanPhamDelegate, VideoMainMenuDelegate, XemThemSanPhamDelegate, TabMenuSelector, NguoiDungChonMenuNhomSanPhamDelegate, ThongBaoDelegate{
    let idCellroot = "idCellroot"
    let idCellrootSldie = "idCellrootSldie"
    
     let idCellStore:[String] = ["idCellrootSldie", "idCellMenuVideo", "idCellMenu", "idCellSanPhamTheoDanhMuc", "idHeader"]
    
    var arraySanPhamTheoNhom:[String:[ModelSanPham]]?
   
    var arraySanPhamTheoNhomConFull:[String:[ModelSanPham]]?{
        didSet{
            collectionView?.reloadData()
        }
    }
    
    var collectionMenuChooss:[Int:UICollectionView]?
    
    var arrDanhSachNhomCon:[ModelNhomSanPhamTheoNhomCha]?
    
    var arrayMenu:[Nhomsanpham]?{
        didSet{
           collectionView?.reloadData()
        }
    }
    
    static var video:Video?
    static var sanPham:ModelSanPham?
    
    
    var indexMenuSelect:Int = 0
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var tabBarBottom:UITabViewBottomController = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        
        let v = UITabViewBottomController(collectionViewLayout: layout)
            v.delegateTabSelector = self
        return v
    }()
    
    var arraySlide:[AFURLSource]?{
        didSet{
            collectionView?.reloadData()
        }
    }
    
    var btnSearch:UIBarButtonItem?
    var btnHome:UIBarButtonItem?
    lazy var search:UISearchBar = {
        let s = UISearchBar(frame: .zero)
            s.placeholder = "Tìm kiếm..."
            s.delegate = self
            return s
    }()
    
    let txtTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.text = "Trang chủ"
        t.textColor = UIColor.white
        t.textAlignment = .center
        return t
    }()
    
    var loadDataFull:Bool = true
    
    
    override func viewDidLoad() {
        _ = SQLiteConfig()
        
        collectionView?.tag = 111111
     
        appDelegate.window?.addSubview(tabBarBottom.view)
        appDelegate.window?.addConstraintsArray(withVisualFormat: "H:|[v0]|", views: tabBarBottom.view)
        appDelegate.window?.addConstraintsArray(withVisualFormat: "V:[v0(50)]|", views: tabBarBottom.view)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 242/255, green: 82/255, blue: 104/255, alpha: 1)
        let imgV = UIImageView(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal))
        imgV.tintColor = UIColor.white
        
      //  btnSearch = UIBarButtonItem(image: imgV.image, style: .done, target: self, action: #selector(TimKiemFunc))
       // btnHome = UIBarButtonItem(image: UIImage(named: "logo_1")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(HomeFunc))
        
       // navigationItem.leftBarButtonItem = btnHome
//        navigationItem.titleView = search
        
        txtTitle.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        navigationItem.titleView = txtTitle
        
        
 
       // collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICellSlideShow.self, forCellWithReuseIdentifier: idCellStore[0])
        
        collectionView?.register(UICellMainMenuVideo.self, forCellWithReuseIdentifier: idCellStore[1])
         collectionView?.register(UICellMainMenu.self, forCellWithReuseIdentifier: idCellStore[2])
         collectionView?.register(UICellNoiBat.self, forCellWithReuseIdentifier: idCellStore[3])
        
        
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
        collectionView?.register(UICellHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: idCellStore[4])
        
        
        GetDataSlide.loadDataSlide("http://lcnails.vn/api/slideapi") { (slide) in
            var array:[AFURLSource] = []
            for items in slide {
                array.append(AFURLSource(urlString: items.urlAnh)!)
            }
            self.arraySlide = array
        }
        
        Nhomsanphams().loadNhomsp("http://lcnails.vn/api/Nhomsanphamapi") { (arr) in
            //self.arrayMenu = arr
            
            var sanPhamTheoNhom:[String:[ModelSanPham]] = [:]
            
            for items in arr {
                ModelSanPham.loadDataOnline(maNhom: items.Nhomsanpham1, { (danhSach, TenNhom) in
                    sanPhamTheoNhom[items.Nhomsanpham1] = danhSach
                    
                    if sanPhamTheoNhom.count == arr.count {
                        self.arraySanPhamTheoNhom = sanPhamTheoNhom
                        self.arrayMenu = arr
                    }
                })
                
            }
        }
        
        //cai dat ban phim
        NotificationCenter.default.addObserver(self, selector: #selector(ShowKeyboarWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HideKeyboarWillShow), name: .UIKeyboardDidHide, object: nil)
        

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
        
        
        //neu san pham hay video # nil thi chay 
        
        if RootViewController.video != nil {
            NguoiDungChonVideoMenu(videoModel: RootViewController.video!)
        }
        
        if RootViewController.sanPham != nil {
            SanPhamClick(sanPham: RootViewController.sanPham!)
        }
        
    }
    
  
    func HomeFunc(){
        print("_________")
    }
  
    
   public func showImageSlide(slideShow: ImageSlideshow){
        
        slideShow.presentFullScreenController(from: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if loadDataFull {
            if let n = arrayMenu?.count {
                return n + 3
            }
            return 0
        } else {
            if let n = arrDanhSachNhomCon?.count {
                return n + 3
            }
            return 0
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //tắt bàn phím
        search.endEditing(false)
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellStore[0], for: indexPath) as! UICellSlideShow
            cell.slideShow.setImageInputs(arraySlide != nil ? arraySlide!:[])
            cell.rootViewControler = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellStore[1], for: indexPath) as! UICellMainMenuVideo
                cell.videoMainMenuDelegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellStore[2], for: indexPath) as! UICellMainMenu
                cell.arrMenu = arrayMenu
                cell.hander = self
            return cell
        default:
            
            if loadDataFull {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellStore[3], for: indexPath) as! UICellNoiBat
               // cell.modelNhomSanPham = arrayMenu?[indexPath.section - 3]
                cell.handerSanPham = self
                    cell.danhSachSanPham = arraySanPhamTheoNhom?[(arrayMenu?[indexPath.section - 3].Nhomsanpham1)!]
                return cell
            } else {
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCellStore[3], for: indexPath) as! UICellNoiBat
                // cell.modelNhomSanPham = arrayMenu?[indexPath.section - 3]
                cell.handerSanPham = self
                cell.danhSachSanPham = arraySanPhamTheoNhomConFull?[(arrDanhSachNhomCon?[indexPath.section - 3].maNhomSanPhamCon!)!]
                return cell
            }
            
            
        }
        
       
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: idCellStore[4], for: indexPath) as! UICellHeader
            return cell
        case 1:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: idCellStore[4], for: indexPath) as! UICellHeader
            return cell
        case 2:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: idCellStore[4], for: indexPath) as! UICellHeader
            return cell
        default:
           
            if loadDataFull {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: idCellStore[4], for: indexPath) as! UICellHeader
                ////  cell.txtHeader.text = arrayMenu?[indexPath.section - 3].Tennhomsanpham
                cell.nhomSanPham = arrayMenu?[indexPath.section - 3]
                cell.viewXemThemSanPham = self
                cell.txt.text = "CHA"
                return cell
            
            } else {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: idCellStore[4], for: indexPath) as! UICellHeader
                ////  cell.txtHeader.text = arrayMenu?[indexPath.section - 3].Tennhomsanpham
                cell.nhomSanPhamCon = arrDanhSachNhomCon?[indexPath.section - 3]
                cell.viewXemThemSanPham = self
                cell.txt.text = "CON"
                return cell
            }
            
           
            
        }
        
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
             return CGSize(width: 0, height: 0)
        case 1:
            return CGSize(width: 0, height: 0)
        case 2:
            return CGSize(width: 0, height: 0)
            
        default:
             return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/8)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/4)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/6)
        default:
            
           // return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65) * 2)
            if loadDataFull {
                
                if arraySanPhamTheoNhom != nil {
                    if (arraySanPhamTheoNhom?[(arrayMenu?[indexPath.section - 3].Nhomsanpham1)!]?.count)! > 6 {
                        return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65) * 2)
                    } else {
                        return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65))
                    }
                } else {
                    return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65) * 2)
                }
            } else {
                
                if arraySanPhamTheoNhomConFull != nil {
                    if (arraySanPhamTheoNhomConFull?[(arrDanhSachNhomCon?[indexPath.section - 3].maNhomSanPhamCon)!]?.count)! > 6 {
                        return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65) * 2)
                    } else {
                        return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65))
                    }
                } else {
                    return CGSize(width: UIScreen.main.bounds.width, height: (EnumSizeCell.imgSanPhamSize.getSize() + 65) * 2)
                }
            }
        }
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.endEditing(false)
    }
   
    func ShowKeyboarWillShow(notification:NSNotification){
        
        if let keyboarSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIWindow.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .autoreverse, animations: {
                self.view.window?.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - keyboarSize.height)
            }, completion: nil)
            
        }
    }
    
    func HideKeyboarWillShow() {
        UIWindow.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .autoreverse, animations: {
            self.view.window?.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
    }
    
    
    func SanPhamClick(sanPham: ModelSanPham) {
       //let layout = UICollectionViewFlowLayout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewChiTiet = storyboard.instantiateViewController(withIdentifier: "SanPhamViewChiTiet") as! SanPhamViewChiTietController
            let formartNumber = NumberFormatter()
                formartNumber.numberStyle = .decimal
            let sp = Sanpham(Dongia: "\(formartNumber.string(from: sanPham.Dongia!)!) đ", Iconimg: sanPham.Iconimg!, Images: sanPham.Images!, Masanpham: sanPham.Masanpham!, Motasanoham: sanPham.Motasanoham!, Nhomsanpham: sanPham.Nhomsanpham!, maNhomSanPhamCon: sanPham.maNhomSanPhamCon!, Tensanpham: sanPham.Tensanpham!, SpLike: Int(sanPham.SlLike!))
            viewChiTiet.SetData(object: sp)
        
        
        self.navigationController?.pushViewController(viewChiTiet, animated: true)
       // performSegue(withIdentifier: "details", sender: self)
        
        
    }
    
    func NguoiDungChonVideoMenu(videoModel: Video) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let videoTableView = story.instantiateViewController(withIdentifier: "VideoTableView") as! VideoTableViewController
            videoTableView.setData(videoData: videoModel)
        self.navigationController?.pushViewController(videoTableView, animated: true)
    }
    
    func NguoiDungXemSanPhamCungLoaiNhomCha(nhomSanPhamCha: Nhomsanpham) {
        SanPhamCungLoaiViewController.idMaNhomSanPham = nhomSanPhamCha.Nhomsanpham1
        ClassSanphamCungLoai.nguoiDungClick = self
        SanPhamCungLoaiViewController.loadDataNhomCon = false
        let layout = UICollectionViewFlowLayout()
        self.navigationController?.pushViewController(SanPhamCungLoaiViewController(collectionViewLayout: layout), animated: true)
    }
    
    func NguoiDungXemSanPhamCungLoaiNhomCon(nhomCon: ModelNhomSanPhamTheoNhomCha) {
        SanPhamCungLoaiViewController.idMaNhomSanPham = nhomCon.maNhomSanPhamCon
         SanPhamCungLoaiViewController.loadDataNhomCon = true
        ClassSanphamCungLoai.nguoiDungClick = self
        let layout = UICollectionViewFlowLayout()
        self.navigationController?.pushViewController(SanPhamCungLoaiViewController(collectionViewLayout: layout), animated: true)
    }
    
    
    func IndexTabSelector(index: Int) {
  
      
        if index != indexMenuSelect {
            
            
            let tbArray:NSMutableArray = NSMutableArray(array: (self.navigationController?.viewControllers)!)
            
            for (index, viewController) in tbArray.enumerated() {
                if index != 0 {
                    tbArray.remove(viewController)
                } else {
                    
                    self.navigationController?.viewControllers = [viewController as! UIViewController]
                }
            }
            
            
            indexMenuSelect = index
            switch index {
            case 0:
                 DispatchQueue.main.async {
                    _ = self.navigationController?.popToRootViewController(animated: true)
                 }
                break
            case 1:
                
                let viewVideo = getUIViewToStoryboard(idStoryboard: "videoView") as! VideoView
                
                viewVideo.imageSlide.setImageInputs(arraySlide != nil ? arraySlide!:[])
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewVideo, animated: true)
                }
                
    
                break
            case 2:
                
                let tbGioHang = getUIViewToStoryboard(idStoryboard: "RoHangTableView") as! RoHangTableViewController
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(tbGioHang, animated: true)
                }
                
                break
                
            case 3:
                let thongBao = getUIViewToStoryboard(idStoryboard: "thongBao") as! ThongBao
                 thongBao.thongBaohandel = self
                 DispatchQueue.main.async {
                    self.navigationController?.pushViewController(thongBao, animated: true)
                }
                
                break
            case 4:
                let ThongTinKhachHang = getUIViewToStoryboard(idStoryboard: "ThongTinKhachHang") as! ThongTinKhachHangViewController
                 DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ThongTinKhachHang, animated: true)
                }
            default:
                 DispatchQueue.main.async {
                    _ = self.navigationController?.popToRootViewController(animated: true)
                 }
                break
            }
        
        }
        
    }
    
  
    
    func getUIViewToStoryboard(idStoryboard:String) -> UIViewController {
         let story = UIStoryboard(name: "Main", bundle: nil)
        return story.instantiateViewController(withIdentifier: idStoryboard)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
 
    func NguoiDungChonMenuNhomSan(modelNhomSanPham: Nhomsanpham, colectionMenu:[Int:UICollectionView]) {
       ModelNhomSanPhamTheoNhomCha.loadNhomConTheoNhomCha(idNhomCha: modelNhomSanPham.Nhomsanpham1) { (danhSachNhomCon) in
        var arrSanPhamTheoNhomCon:[String:[ModelSanPham]] = [:]
        
        for items in danhSachNhomCon {
            ModelSanPham.loadDataOnlineTheoNhomCon(maNhomCon: items.maNhomSanPhamCon!, { (dssp, tenNhom) in
                arrSanPhamTheoNhomCon[items.maNhomSanPhamCon!] = dssp
     
                
                if arrSanPhamTheoNhomCon.count == danhSachNhomCon.count {
                    self.loadDataFull = false
                    self.arrDanhSachNhomCon = danhSachNhomCon
                    self.arraySanPhamTheoNhomConFull = arrSanPhamTheoNhomCon
                    self.collectionMenuChooss = colectionMenu
                    
                }
            })
         }
       }
    }
    
    //Thong Bao
    func NguoiDungChonThongBao(tb: ModelThongBao) {
      //  print(tb.nhomThongBao!)
        if tb.nhomThongBao == "sanPham" {
            let sp = ModelSanPham()
            
            sp.Masanpham = tb.Masanpham
            sp.Makhachhang = tb.Makhachhang
            sp.Nhomsanpham = tb.Nhomsanpham
            sp.Tensanpham = tb.Tensanpham
            sp.Motasanoham = tb.Motasanoham
            sp.Dongia = tb.Dongia
            sp.Soluong = tb.Soluong
            sp.Ngaytao = tb.Ngaytao
            sp.Thutu = tb.Thutu
            sp.Iconimg = tb.Iconimg
            sp.Images = tb.Images
            sp.maNhomSanPhamCon = tb.maNhomSanPhamCon
            sp.SlLike = 0
            sp.Giacu = 0
            SanPhamClick(sanPham: sp)
        }
        
        if tb.nhomThongBao == "videos" {
            
            NguoiDungChonVideoMenu(videoModel: Video(Idvideo: tb.Idvideo!, Mota: tb.Mota!, Nhomsanpham: tb.Nhomsanpham!, Tenvideo: tb.Tenvideo!, tieuDe: "", noiDung: ""))
        }
    }
    
    
}
