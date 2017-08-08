//
//  RoHangTableViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/24/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import Foundation

var mangKhachHang:[KhachHangClass] = []
class RoHangTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    let db:SQLiteConfig = SQLiteConfig()
    
    @IBOutlet weak var btnXacNhanDonHangView: UIButton!
    @IBOutlet weak var txtTongTienDonHang: UILabel!
    
    let isConnectInternet:CheckInternetConnectClass = CheckInternetConnectClass()
    
    //mang các sản phẩm trong rỏ hàng
    var mangCacSanPhamTrongRo:[SanPhamTrongRoHangClass] = []
    //mang Thông tin khachHang
    
    
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
    
    var txtTenSanPham:UITextField = UITextField()
    var txtTongTien:UITextField = UITextField()
    var txtSoLuong:UITextField = UITextField()
    
    @IBOutlet weak var tbViewRoHang: UITableView!
    
    let txtTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.text = "Giỏ hàng"
        t.textColor = UIColor.white
        t.textAlignment = .center
        return t
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        txtTitle.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        navigationItem.titleView = txtTitle
        
        tbViewRoHang.dataSource = self
        tbViewRoHang.delegate = self
        txtSoLuong.delegate = self
        
        btnXacNhanDonHangView.layer.borderWidth = 0.5
        btnXacNhanDonHangView.layer.borderColor = UIColor.blue.cgColor
        btnXacNhanDonHangView.layer.cornerRadius = 5
        
        
        let _ = db.OpenOrCreateDatabase()
        
        mangCacSanPhamTrongRo = db.LayTatCacSanPhamTrongRo()
        var st:Int = 0
        for item in mangCacSanPhamTrongRo{
            st = st + Int(item.tongTien)!
            txtTongTienDonHang.text = DinhDangTien.string(from: st as NSNumber)
            
        }
        mangKhachHang = db.ThonTinKhachHangDatDon()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        mangCacSanPhamTrongRo = db.LayTatCacSanPhamTrongRo()
        if(mangCacSanPhamTrongRo.count != 0){
            var st:Int = 0
            for item in mangCacSanPhamTrongRo{
                st = st + Int(item.tongTien)!
                txtTongTienDonHang.text = DinhDangTien.string(from: st as NSNumber)
                
            }
            self.tbViewRoHang.reloadData()
        }else{
            txtTongTienDonHang.text = "0 đ"
        }
        
        
    }
    
    
    func loadData(){
        // mangCacSanPhamTrongRo = []
        mangCacSanPhamTrongRo = db.LayTatCacSanPhamTrongRo()
        if(mangCacSanPhamTrongRo.count != 0){
            var st:Int = 0
            for item in mangCacSanPhamTrongRo{
                st = st + Int(item.tongTien)!
                txtTongTienDonHang.text = DinhDangTien.string(from: st as NSNumber)
                
            }
            self.tbViewRoHang.reloadData()
        }else{
            txtTongTienDonHang.text = "0 đ"
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //muốn trả về bao nhiêu sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //số phần tử
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mangCacSanPhamTrongRo.count
    }
    
    /// hiển thị thông tin
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemRohangTableViewCell
        cell.txtTenSanPham.text = mangCacSanPhamTrongRo[indexPath.row].tenSanPham
        cell.txtGiaSanPham.text = DinhDangTien.string(from: NSNumber.init(value: Int(mangCacSanPhamTrongRo[indexPath.row].giaSanPham)!))
        cell.txtSoLuong.text = mangCacSanPhamTrongRo[indexPath.row].soLuong
        cell.txtTongTien.text = DinhDangTien.string(from: NSNumber.init(value: Int(mangCacSanPhamTrongRo[indexPath.row].tongTien)!))
        // cell.imgSanPham.image = UIImage(named: (mangCacSanPhamTrongRo[indexPath.row].hinhSanPham));
        asyncLoadShotImage((mangCacSanPhamTrongRo[indexPath.row].hinhSanPham), imageView: cell.imgSanPham)
        
        
        return cell
    }
    
    
    //Cho biet phan tu nao nguoi dung chon
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isEditing = !tableView.isEditing
    }
    //-*
    
    func asyncLoadShotImage(_ shot: String, imageView : UIImageView){
        
        //var imageData : Data?
        if shot == ""
        {
            return
        }
        let downloadQueue = DispatchQueue(label: "com.SALEAPP.processsdownload", attributes: [])
        
        downloadQueue.async {
            
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
    
    
    
    
    // thêm button action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionRowXoa:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Xoá",handler: {(actionXoa:UITableViewRowAction, indexPathAction:IndexPath) in
            
            self.XoaSanPhamTrongDongHang(indexPath: indexPath)
            
        })
        //actionRowXoa.backgroundColor = #colorLiteral(red: 1, green: 0.1089438941, blue: 0, alpha: 1)
        
        let actionRowHuy:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Huỷ", handler:{(action:UITableViewRowAction, indexPath:IndexPath) in
            tableView.isEditing = !tableView.isEditing
        })
        // actionRowHuy.backgroundColor = #colorLiteral(red: 0, green: 0.7647058964, blue: 0.2826511778, alpha: 1)
        
        let actionRowSuaSoLuong:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Sửa", handler: {(actionSuaSoLuong:UITableViewRowAction, indexPathSuaSoLuong:IndexPath) in
            //self.AlerCustom()
            self.SuaSoLuongDonHang(index: indexPath)
        })
        
        // actionRowSuaSoLuong.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        return [actionRowXoa, actionRowSuaSoLuong, actionRowHuy]
        
    }
    
    
    
    
    func XoaSanPhamTrongDongHang(indexPath: IndexPath)
    {
        let alerDialog:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn xoá!", preferredStyle: UIAlertControllerStyle.alert)
        let actionXoa:UIAlertAction = UIAlertAction(title: "Đồng Ý", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
            
            self.db.XoaSanPhamTrongRoHang(maSanPhamTrongRo: self.mangCacSanPhamTrongRo[indexPath.row].maSanPhamTrongRo)
            
            self.mangCacSanPhamTrongRo.remove(at: indexPath.row)
            
            
            if(self.mangCacSanPhamTrongRo.count != 0){
                var st:Int = 0
                for item in self.mangCacSanPhamTrongRo{
                    st = st + Int(item.tongTien)!
                    self.txtTongTienDonHang.text = self.DinhDangTien.string(from: st as NSNumber)
                }
            }else{
                self.txtTongTienDonHang.text = "0 đ"
            }
            
            self.tbViewRoHang.reloadData()
            
        })
        let actionHuy:UIAlertAction = UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in})
        
        
        alerDialog.addAction(actionXoa)
        alerDialog.addAction(actionHuy)
        self.present(alerDialog, animated: true, completion: nil)
        
    }
    
    func SuaSoLuongDonHang(index: IndexPath)
    {
        
        let alerDialogSuaDonhang:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn hãy nhập số lượng!", preferredStyle: UIAlertControllerStyle.alert)
        
        
        alerDialogSuaDonhang.addTextField { (UITextField3) in
            self.txtSoLuong = UITextField3
            self.txtSoLuong.keyboardType = UIKeyboardType.numberPad
            self.txtSoLuong.placeholder = "Mời bạn nhập số lượng!"
            
            
        }
        
        
        
        
        let actionSoLuongDongY:UIAlertAction = UIAlertAction(title: "Đồng Ý", style: UIAlertActionStyle.default, handler: {(UIAlertActionDongY) in
            
            //print(Int(self.txtSoLuong.text!)!)
            
            if (self.txtSoLuong.text?.characters.count != 0) && (self.txtSoLuong.text! != "0")  {
                if (  Int(self.txtSoLuong.text!))! >= 1000 {
                    self.ThongBao(noiDung: "Số lượng đặt max là 1000 sản phẩm !\nThao tác không được thực hiện !")
                } else {
                    //let gia:Int = Int((txtGiaSanPham.text?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " đ", with: ""))!)!
                    let tongTienSauSua:Int = Int(self.mangCacSanPhamTrongRo[index.row].giaSanPham)! * Int(self.txtSoLuong.text!)!
                    //sqlite3_close(self.db)
                    if self.db.SuaSoLuongSanPham(maSanPham: self.mangCacSanPhamTrongRo[index.row].maSP, soLuongEdit: self.txtSoLuong.text!, tongTien: String(tongTienSauSua)) {
                        //self.ThongBao(noiDung: "Sửa thành công!")
                        self.loadData()
                    }
                }
            }else{
                self.ThongBao(noiDung: "Thao tác không được thực hiện bạn vui lòng nhập số lượng lớn hơn 0, không được bỏ trống!")
            }
            
        })
        
        let actionSoLuongHuy:UIAlertAction = UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.default, handler: {(UIAlertActionHuy) in
            
        })
        alerDialogSuaDonhang.addAction(actionSoLuongDongY)
        alerDialogSuaDonhang.addAction(actionSoLuongHuy)
        self.present(alerDialogSuaDonhang, animated: true, completion: nil)
        
        
    }
    
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //Xác nhận đơn hàng
    @IBAction func btnXacNhanDonHang(_ sender: Any) {
        
        if isConnectInternet.cisInternetAvailable() {
            //mangKhachHang = db.ThonTinKhachHangDatDon()
            if mangKhachHang[0].diaChi == "update" || mangKhachHang[0].soDienThoai == "update" {
                MainHinhTabBarViewController.itemSelectTabbarMenu.selectedIndex = 4
                ThongBao(noiDung: "Bạn vui lòng cập nhật địa chỉ và số điện thoại!")
            } else {
                
                if mangCacSanPhamTrongRo.count > 0 {
                    //Ma đơn đặt hàng
                    let maDonDathang = MaDonHang(textRandom: randomString(length: 32))
                    
                    ///
                    let url:URL = URL(string: "http://lcnails.vn/api/DonhangApi")!
                    
                    //Tạo đổi tượng khách hàng
                    let khachHangDaton:NSDictionary = ["Madondat": maDonDathang, "Makhachhang": mangKhachHang[0].maKhachHang, "Tenkhachhang": mangKhachHang[0].tenKhachHang, "Diachi": mangKhachHang[0].diaChi, "Sodienthoai": mangKhachHang[0].soDienThoai]
                    
                    let request = NSMutableURLRequest(url: url as URL)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    request.httpBody = try! JSONSerialization.data(withJSONObject: khachHangDaton, options: [])
                    
                    // print(khachHang)
                    
                    let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
                        
                        let httpStatus = response as? HTTPURLResponse
                        if (httpStatus != nil){
                            if httpStatus!.statusCode == 201
                            {
                                
                                ///
                                DispatchQueue.main.sync {
                                    //Gửi đơn hàng chi tiết
                                    self.guiDonHangChiTiet(maDonHang: maDonDathang)
                                }
                                
                            }
                            else
                            {
                                self.ThongBao(noiDung: "Xác nhận đơn hàng không thành công!")
                                
                            }
                            //            if(statusCode == 201)
                            //            {
                            //                self.ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
                            //            }
                            
                        }else {
                            DispatchQueue.main.sync {
                                //Gửi đơn hàng chi tiết
                                self.ThongBao(noiDung: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                            }
                        }
                    }
                    
                    task.resume()
                    
                    ///
                    
                    
                } else {
                    ThongBao(noiDung: "Bạn vui lòng thêm sản phẩm vào rỏ!")
                }
            }
        }
        else {
            self.ThongBao(noiDung: "Chức năng này cần internet!")
        }
        
        
        
    }
    
    //randomtext
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    //get Date
    
    func MaDonHang(textRandom:String) -> String{
        //GET DATE
        let toDay = Date()
        let fomatDate = DateFormatter()
        fomatDate.dateFormat = "ddMMyyyyhhMMss"
        return (fomatDate.string(from: toDay) + textRandom)
    }
    
    
    //Gửi chi tiết đơn hàng
    func guiDonHangChiTiet(maDonHang:String){
        let urlDanHangChiTiet:URL = URL(string: "http://lcnails.vn/api/DathangctApi")!
        
        
        
        for item in self.mangCacSanPhamTrongRo {
            
            let requestx = NSMutableURLRequest(url: urlDanHangChiTiet as URL)
            //Tạo đổi tượng khách hàng
            let donHangChiTiet:NSDictionary = ["Madondat": maDonHang, "Masanpham": item.maSP, "Soluong": item.soLuong, "Dongia": item.giaSanPham, "Thanhtien": item.tongTien]
            
            
            requestx.httpMethod = "POST"
            requestx.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requestx.addValue("application/json", forHTTPHeaderField: "Accept")
            
            requestx.httpBody = try! JSONSerialization.data(withJSONObject: donHangChiTiet, options: [])
            //
            print(donHangChiTiet)
            
            let taskx = URLSession.shared.dataTask(with: requestx as URLRequest) { datax,responsex,errorx in
                
                let httpStatusx = responsex as? HTTPURLResponse
                if httpStatusx!.statusCode == 201
                {
                    
                    ///
                    DispatchQueue.main.sync {
                        
                        self.db.XoaTatCacSanPhamTrongRoHang()
                        self.mangCacSanPhamTrongRo.removeAll()
                        self.txtTongTienDonHang.text = "0 đ"
                        self.tbViewRoHang.reloadData()
                        
                        self.ThongBao(noiDung: "Gửi đơn hàng thành công!")
                        
                        
                    }
                    
                }
                else
                {
                    
                    self.ThongBao(noiDung: "Gửi chi tiết đơn hàng không thành công!" + String(httpStatusx!.statusCode))
                    
                }
                //            if(statusCode == 201)
                //            {
                //                self.ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
                //            }
                
            }
            
            
            taskx.resume()
            
        }
        
        // print(khachHang)
        
        
    }
    
}
