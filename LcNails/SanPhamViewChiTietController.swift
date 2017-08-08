//
//  SanPhamViewChiTietController.swift
//  LcNails
//
//  Created by Lam Tung on 11/22/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow

var dataSetBL_idDoiTuong:String!
var dataSetBL_tenSanPham:String!
var arrImageSabPhamBL:[AFURLSource] = []



class SanPhamViewChiTietController: UIViewController, UITextFieldDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    static var showView:HomeView?
    static var TextTimKiem:String = "ConGa"
    static var nguoiDunglike:FunctionProtocol?
    
    
    
    //định dạng tiền
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
    
    var tongTien:Int = Int()
    var screenManHinh:CGRect = CGRect()
    
    let db:SQLiteConfig = SQLiteConfig()
    var mangKhachHang:[KhachHangClass] = []
    
    
    
    @IBOutlet weak var scrollViewChiTiet: UIScrollView!
    @IBOutlet weak var btndathangView: UIButton!
    @IBOutlet weak var outBtnBtnBinhLuan: UIButton!
    @IBOutlet weak var slideViewSanPham: UIView!
    @IBOutlet weak var viewThongTinSanPham: UIView!
    @IBOutlet weak var txtViewMota: UILabel!
    @IBOutlet weak var txtTenSanPham: UILabel!
    @IBOutlet weak var txtGiaSanPham: UILabel!
    @IBOutlet weak var txtSoLuong: UITextField!
    @IBOutlet weak var txtTongTien: UILabel!
    @IBOutlet weak var layoutlienquan: UICollectionViewFlowLayout!
    @IBOutlet weak var splienquanView: UICollectionView!
    
    
    @IBOutlet weak var imageLike: UIButton!
    
    @IBOutlet weak var txtViewLike: UILabel!
    @IBAction func btnSetDataBinhLuan(_ sender: Any) {
        
        dataSetBL_idDoiTuong = sanpamObject.Masanpham
        dataSetBL_tenSanPham = sanpamObject.Tensanpham
        
    }
    
    
    
    var frameviewThongTinSanPham:CGRect = CGRect()
    
    var sanpham :[Sanpham]!
    var idImgStart:Int = 0
    
    var arrImg:[AFURLSource] = []
    
    //
    var nsTime:Timer = Timer()
    var sanpamObject : Sanpham!
    var cellHeight : CGFloat = 240
    var api : Sanphams!
    
    @IBAction func btnDatHang(_ sender: Any) {
        
        if txtSoLuong.text == "" || txtSoLuong.text == "0"{
            
            txtSoLuong.becomeFirstResponder()
            ThongBao(noiDung: "Số lượng không được để trống phải khách 0!")
            return
        }
        
        
        if Int((txtTongTien.text?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " đ", with: "").replacingOccurrences(of: ",", with: ""))!)! > 1 {
            
            if  db.ThemSanPhamVaoRoHang(maRoHang: "", maSP: sanpamObject.Masanpham, tenSanPham: sanpamObject.Tensanpham, giaSanPham: sanpamObject.Dongia.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " đ", with: "").replacingOccurrences(of: ",", with: ""), soLuong: (txtSoLuong.text?.trimmingCharacters(in: .whitespaces))!, hinhSanPham: sanpamObject.Iconimg, tongTien: (txtTongTien.text?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " đ", with: "").replacingOccurrences(of: ",", with: ""))!, maKhachHang: "") {
                
                //goBack()
                
                ThongBaoThanhCong(noiDung: "Thêm sản phẩm vào rỏ thành công!")
                
                
            } else {
                ThongBao(noiDung: "Thao tác không được thực hiên, bạn vui lòng thử lại!")
            }
            
        } else {
            ThongBao(noiDung: "Thao tác không được thực hiên, bạn vui lòng thử lại!")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        if SanPhamViewChiTietController.TextTimKiem != "ConGa" && SanPhamViewChiTietController.TextTimKiem != "" {
        //            SanPhamCungLoaiViewController.BackSearch(textShearch: SanPhamViewChiTietController.TextTimKiem)
        //
        //            let layout = UICollectionViewFlowLayout()
        //            let viewController = SanPhamCungLoaiViewController(collectionViewLayout: layout)
        //            navigationController?.pushViewController(viewController, animated: true)
        //
        //            SanPhamViewChiTietController.TextTimKiem = "ConGa"
        //
        //        }
    }
    
    public func SetData(object:Sanpham){
        self.sanpamObject = object
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewadd = navigationController?.navigationBar.viewWithTag(9999) {
            viewadd.removeFromSuperview()
        }
        
        
        
        splienquanView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 350, 0)
        splienquanView.contentInset = UIEdgeInsetsMake(0, 0, 350, 0)
        scrollViewChiTiet.contentInset = UIEdgeInsetsMake(-70, 0, 150, 0)
        scrollViewChiTiet.scrollIndicatorInsets = UIEdgeInsetsMake(-70, 0, 150, 0)
        scrollViewChiTiet.showsVerticalScrollIndicator = false
        //        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        //        self.navigationItem.setHidesBackButton(true, animated: false)
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SanPhamViewChiTietController.goBack))
        
        // print("isBeingDismissed",isBeingDismissed)
        //
        mangKhachHang = db.ThonTinKhachHangDatDon()
        // scrollViewChiTiet.translatesAutoresizingMaskIntoConstraints = false
        splienquanView.delegate = self
        splienquanView.dataSource = self
        splienquanView.contentInset = UIEdgeInsetsMake(0, 6, 0, 6)
        
        layoutlienquan.minimumInteritemSpacing = 2
        layoutlienquan.minimumLineSpacing = 4
        
        let cellWidth = calcCellWidth(self.view.frame.size) - 8
        cellHeight = cellWidth * 4/3.5
        layoutlienquan.itemSize = CGSize(width: cellWidth , height: cellHeight )
        self.sanpham = [Sanpham]()
        self.api = Sanphams()
        print(sanpamObject.Masanpham)
        api.loadSanpham("http://lcnails.vn/api/sanphamapi/?sanPhamLienQuan="+sanpamObject.Masanpham.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!, completion: didLoadShots)
        //tach link
        let arrImageLink = sanpamObject.Images.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
        
        for url in arrImageLink
        {
            if url != "" {
                arrImg.append(AFURLSource(urlString: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
            }
            arrImageSabPhamBL = arrImg
            
        }
        
        
        setupSlide()
        //print(arrImg)
        txtViewMota.lineBreakMode = .byWordWrapping
        //        txtViewMota.sizeToFit()
        txtTenSanPham.text = sanpamObject.Tensanpham
        txtGiaSanPham.text = sanpamObject.Dongia
        txtViewMota.text = sanpamObject.Motasanoham
        txtViewLike.text = String(sanpamObject.splike).replacingOccurrences(of: ".0", with: "")
        //imgSlide.image = UIImage(named: "logo_1.png")
        
        //  arrImg = sanpamObject.Images as! [String]
        
        
        txtSoLuong.delegate = self
        
        btndathangView.layer.borderWidth = 0.5
        btndathangView.layer.borderColor = UIColor.blue.cgColor
        btndathangView.layer.cornerRadius = 5
        
        //
        outBtnBtnBinhLuan.layer.borderWidth = 0.5
        outBtnBtnBinhLuan.layer.borderColor = UIColor.blue.cgColor
        outBtnBtnBinhLuan.layer.cornerRadius = 5
        
        //
        txtSoLuong.layer.borderWidth = 0.5
        txtSoLuong.layer.borderColor = UIColor.blue.cgColor
        txtSoLuong.layer.cornerRadius = 5
        
        
        //Dịch o nhập lên khi mở bàn phím
        //NotificationCenter.default.addObserver(self, selector: #selector(SanPhamViewChiTietController.keyBoardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(SanPhamViewChiTietController.keyBoarHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        txtSoLuong.addTarget(self, action: #selector(SanPhamViewChiTietController.TinhTienTuDong), for: UIControlEvents.editingChanged)
        
        
        checkLike(maSP: sanpamObject.Masanpham, maKH: mangKhachHang.count > 0 ? mangKhachHang[0].maKhachHang:"1")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        collectionView.isScrollEnabled = false
        collectionView.frame.size = CGSize(width: Int(self.view.frame.width), height: ((sanpham.count * Int(cellHeight))/2) + Int(cellHeight) + 20)
        scrollViewChiTiet.contentSize = CGSize( width: Int(self.view.frame.width), height: Int(collectionView.frame.size.height) + Int(cellHeight) + 20)
        sanPhamLienQuanView.frame.size = CGSize( width: Int(self.view.frame.width), height: Int(collectionView.frame.size.height) + Int(cellHeight) + 20)
        // sanPhamLienQuanView.layer.borderWidth = 1
        return sanpham.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellLienquan", for: indexPath) as! SpLienquanCollectionViewCell
        
        let sanphamct = sanpham[indexPath.row]
        
        //cell.dongiaLabel.text = sanphamct.Dongia
        cell.splienquanLbl.text = sanphamct.Tensanpham
        cell.SplienquanImg.image = nil
        Utils.asyncLoadShotImage(sanphamct, imageView: cell.SplienquanImg)
        //
        cell.layer.borderColor = UIColor(white: 0.65, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 0
        cell.layer.borderWidth = 0.5
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "chitiet", sender: self)
        
        //        if collectionView == self.collectionView {
        //            performSegue(withIdentifier: "details", sender: self)
        //        }
        //        else{
        //            let nhomsp = nhomsanpham[indexPath.row]
        //            print(nhomsp.Tennhomsanpham)
        //            let url = "http://lcnails.vn/api/sanphamapi/?idNhom="+nhomsp.Nhomsanpham1
        //            self.sanpham = [Sanpham]()
        //            self.api = Sanphams()
        //            api.loadSanpham(url, completion: didLoadShots)
        //        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chitiet"){
            
            let selectedItems = splienquanView.indexPathsForSelectedItems
            
            if let sItem = selectedItems as [IndexPath]!{
                //                navigationController?.navigationBar.isTranslucent = true
                //                navigationController?.isNavigationBarHidden = false
                let shot = sanpham[sItem[0].row]
                let controller = segue.destination as! SanPhamViewChiTietController
                controller.sanpamObject = shot
                
            }
        }
    }
    
    
    func goBack() {
        
        _ = self.navigationController?.popViewController(animated: true)
        
        //println("back")
        
    }
    
    
    func didLoadShots(_ loadedShots: [Sanpham]){
        
        for shot in loadedShots {
            self.sanpham.append(shot)
        }
        if self.sanpham.count == 0
        {
            return
        }
        splienquanView.reloadData()
    }
    
    func calcCellWidth(_ size: CGSize) -> CGFloat {
        let transitionToWide = size.width > size.height
        var cellWidth = size.width / 2
        
        if transitionToWide {
            cellWidth = size.width / 3
        }
        
        return cellWidth
    }
    
    
    
    
    func TinhTienTuDong(){
        if txtSoLuong.text != "0" {
            if txtSoLuong.text != "-" {
                if txtSoLuong.text != "" {
                    let gia:Int = Int((txtGiaSanPham.text?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " đ", with: "").replacingOccurrences(of: ",", with: ""))!)!
                    tongTien = Int(txtSoLuong.text!)! * gia
                    if Int(txtSoLuong.text!)! <= 9999 {
                        
                        txtTongTien.text = self.DinhDangTien.string(from: tongTien as NSNumber )
                        // print("mua it the" )
                    }else{
                        ThongBao(noiDung: "Số lượng bạn đặt quá lớn vui lòng liên hệ trực tiếp với nhà phân phối!")
                        txtSoLuong.text = ""
                        txtTongTien.text = "0 đ"
                    }
                } else {
                    txtTongTien.text = "0 đ"
                }
            } else {
                txtSoLuong.text = ""
            }
            
        } else {
            ThongBao(noiDung: "Số lượng phải # 0!")
            txtSoLuong.text = ""
            txtTongTien.text = "0 đ"
        }
        
    }
    
    
    func keyBoardDidShow(notification :NSNotification)
    {
        if let frameObject: AnyObject = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
        {
            let keyboardRect = frameObject.cgRectValue
            
            if screenManHinh.height < 736 {
                viewThongTinSanPham.frame = CGRect(x: 0.0, y: (keyboardRect?.height)!/2 , width: frameviewThongTinSanPham.width, height: frameviewThongTinSanPham.height)
            }
            
        }
    }
    
    func keyBoarHide(notification:NSNotification){
        
        if let _: AnyObject = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
        {
            
            viewThongTinSanPham.frame = frameviewThongTinSanPham
            
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var sanPhamLienQuanView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        screenManHinh = UIScreen.main.bounds
        //188.0 splienquanView.frame.height
        
        
        
    }
    
    
    
    
    let slide = ImageSlideshow()
    
    func setupSlide() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SanPhamViewChiTietController.didTap))
        
        
        slide.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: slideViewSanPham.frame.height)
        slide.contentScaleMode = UIViewContentMode.scaleToFill
        
        slide.slideshowInterval = 5
        if arrImg.count != 0 {
            slide.setImageInputs(arrImg)
        } else {
            slide.setImageInputs([ImageSource(image: UIImage(named: "update")!)])
        }
        
        slide.addGestureRecognizer(gestureRecognizer)
        slideViewSanPham.addSubview(slide)
    }
    
    // cham vao view full anh
    func didTap() {
        slide.presentFullScreenController(from: self)
    }
    
    func asyncLoadShotImage(_ shot: String, imageView : UIImageView){
        
        //var imageData : Data?
        if shot == ""
        {
            return
        }
        let downloadQueue = DispatchQueue(label: "com.SALEAPP.processsdownload", attributes: [])
        
        downloadQueue.async {
            
            // print(data)
            
            let data = try? Data(contentsOf: URL(string: shot)!)
            
            var image : UIImage?
            if data != nil {
                //imageData = data
                image = UIImage(data: data!)!
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    func ThongBaoThanhCong(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(ac) in
            self.goBack()
            // itemSelectTabbarMenu.selectedIndex = 0
        })
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func btnSendLike(_ sender: Any) {
        
        // self.txtViewLike.text = String((Int(self.txtViewLike.text!))! + 1)
        //self.imageLike.setBackgroundImage(UIImage(named: "like_flat"), for: .normal)
        
        let ulr:URL = URL(string: "http://lcnails.vn/api/spLikes")!
        //  self.txtViewLike.text = "93899"
        let requestx = NSMutableURLRequest(url: ulr as URL)
        //Tạo đổi tượng khách hàng
        let spLike:NSDictionary = ["Masanpham": sanpamObject.Masanpham, "Makhachhang": mangKhachHang[0].maKhachHang, "spLike1": true]
        
        
        requestx.httpMethod = "POST"
        requestx.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestx.addValue("application/json", forHTTPHeaderField: "Accept")
        
        requestx.httpBody = try! JSONSerialization.data(withJSONObject: spLike, options: [])
        //
        // print(donHangChiTiet)
        
        let taskx = URLSession.shared.dataTask(with: requestx as URLRequest) { datax,responsex,errorx in
            
            let httpStatusx = responsex as? HTTPURLResponse
            if httpStatusx!.statusCode == 201
            {
                
                ///
                //  DispatchQueue.main.sync {
                
                //
                
                let LinkGetLike:URL = URL(string: "http://lcnails.vn/api/sanphamapi/?masanphamLike=" + self.sanpamObject.Masanpham.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! )!
                let rqLike = NSMutableURLRequest(url: LinkGetLike as URL)
                let taskLike = URLSession.shared.dataTask(with: rqLike as URLRequest) { data,response,error in
                    guard error == nil && data != nil else
                    {
                        print("Error:"," lỗi")
                        return
                    }
                    
                    let httpStatus = response as? HTTPURLResponse
                    
                    if httpStatus!.statusCode == 200
                    {
                        if data?.count != 0 {
                            let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                            if let dataLike = responseString as? [[String:AnyObject]]
                            {
                                //print(dataLike)
                                DispatchQueue.main.sync {
                                    for a in dataLike {
                                        self.txtViewLike.text = String(a["SlLike"]! as! Int)
                                        SanPhamViewChiTietController.nguoiDunglike?.NguoiDungThichSanPham(maSanPham: self.sanpamObject.Masanpham, soLuotLike: a["SlLike"]! as! Int)
                                        
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
                taskLike.resume()
            }
            
        }
        
        //  }
        
        taskx.resume()
        
    }
    
    
    
    
    func checkLike(maSP:String, maKH:String) {
        
        let LinkGetLike:URL = URL(string: "http://lcnails.vn/spLikes/" + maSP.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! + "/" + maKH.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! + "/GetspLike")!
        let rqLike = NSMutableURLRequest(url: LinkGetLike as URL)
        let taskLike = URLSession.shared.dataTask(with: rqLike as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," lỗi")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                
                self.imageLike.setBackgroundImage(UIImage(named: "like_flat"), for: .normal)
                
            } else {
                self.imageLike.setBackgroundImage(UIImage(named: "like_click"), for: .normal)
                //imageLike.currentBackgroundImage = UIImage(named: "like_click")
            }
            
            
        }
        taskLike.resume()    }
}




