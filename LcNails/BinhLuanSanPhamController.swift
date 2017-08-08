//
//  BinhLuanSanPhamController.swift
//  LcNails
//
//  Created by Nong Than on 12/7/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow
class BinhLuanSanPhamController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {

    
    
    //
    let slideShow = ImageSlideshow()
  
    var dataSanPhamView:SanPhamViewChiTietController!
    
    
    let db:SQLiteConfig = SQLiteConfig()
    var arrComment:[[String:AnyObject]] = []
    var arrKhachHangBinh:[KhachHangClass] = []
    let  cellName:String = "cellTable"
    
    @IBOutlet weak var txtTenSanPham: UILabel!
    
    @IBOutlet weak var tableViewController: UITableView!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var viewControllerComment: UIView!
    @IBOutlet weak var scrollViewComment: UIScrollView!
    
    var contenInsetScroll:UIEdgeInsets = UIEdgeInsets.zero
     var scrollContemInset:UIEdgeInsets = UIEdgeInsets.zero
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtTenSanPham.text = dataSetBL_tenSanPham
        
        arrKhachHangBinh = db.ThonTinKhachHangDatDon()
        txtComment.delegate = self
        tableViewController.delegate = self
        tableViewController.dataSource = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeView.didTap))
        if arrImageSabPhamBL.count != 0 {
            slideShow.setImageInputs(arrImageSabPhamBL)
        } else {
            slideShow.setImageInputs([ImageSource(imageString:  "update")!])
        }
        
        slideShow.frame = CGRect(x: 0, y: 55, width: self.view.frame.width, height: 200)
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideShow.slideshowInterval = 5
        
        tableViewController.contentInset = UIEdgeInsetsMake(210, 0, tableViewController.contentInset.bottom, 0)
        tableViewController.scrollIndicatorInsets = UIEdgeInsetsMake(210, 0, tableViewController.contentInset.bottom, 0)
        
        slideShow.addGestureRecognizer(gestureRecognizer)
        scrollViewComment.addSubview(slideShow)
        //
        viewKeyBoard()
        LoadDataComment(idDoiTuong: dataSetBL_idDoiTuong)
    }

    func viewKeyBoard(){
        NotificationCenter.default.addObserver(self, selector: #selector(BinhLuanSanPhamController.showKeyBord(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BinhLuanSanPhamController.hideKeyBoard), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func showKeyBord(notification: NSNotification){
    
        if let keyboardObject:AnyObject = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
        {
            let frameKey = keyboardObject.cgRectValue
            
            scrollViewComment.contentInset = UIEdgeInsetsMake(scrollViewComment.contentInset.top, 0, (frameKey?.height)!, 0)
            scrollViewComment.scrollIndicatorInsets = UIEdgeInsetsMake(scrollViewComment.contentInset.top, 0, (frameKey?.height)!, 0)
        }
        
    }
    
    
    func  hideKeyBoard() {
        
        scrollViewComment.contentInset = contenInsetScroll
        scrollViewComment.scrollIndicatorInsets = scrollContemInset
        
    }
    
    
    // cham vao view full anh
    func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
   
    @IBAction func btnSendComment(_ sender: Any) {
        
        
        if txtComment.text == "" {
            ThongBao(noiDung: "Mời bạn nhập nội dung!")
            txtComment.becomeFirstResponder()
            return
        }
        
        
         GuiBinhLuan(Iddoituong: dataSetBL_idDoiTuong, Noidung: txtComment.text!.trimmingCharacters(in: .whitespaces), tenNguoiBinhLuan: arrKhachHangBinh[0].tenKhachHang, Ngaytao: LayKyDangKyTheoThoiGian())
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        contenInsetScroll = scrollViewComment.contentInset
        scrollContemInset = scrollViewComment.scrollIndicatorInsets
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtComment.resignFirstResponder()
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! BinhLuanSanPhamCell
        cell.txtTenNguoiBinh.text = arrComment[indexPath.row]["tenNguoiBinhLuan"] as! String!
        
        cell.txtNoiDungBinh.text = arrComment[indexPath.row]["Noidung"] as! String!
        
        cell.txtNoiDungBinh.numberOfLines = 0
//        cell.txtNoiDungBinh.sizeToFit()
//        print(cell.txtNoiDungBinh.frame.height)
//        tableView.rowHeight = cell.txtNoiDungBinh.frame.height + 80
        return cell
    }
    
    //
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    
    
    func LoadDataComment(idDoiTuong:String) {
        
        let url:URL = URL(string:  "http://lcnails.vn/BinhluanApi/\(idDoiTuong)/LayBinhLuanTheoVideo")!
        
        // let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," Lỗi load data comment!")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self.arrComment = responseString as! [[String:AnyObject]]
                    DispatchQueue.main.sync {
                        
                        self.tableViewController.reloadData()
                        
                    }
                    //
                    
                    
                }
                else
                {
                    print("không có dữ liệu comment!")
                }
            }
            else
            {
                print("error laod data comment httpstatus code is :",httpStatus!.statusCode)
            }
        }
        task.resume()
        
    }
    
    
    //Gửi bình luận
    func GuiBinhLuan(Iddoituong:String, Noidung:String, tenNguoiBinhLuan:String, Ngaytao:String){
        let url:URL = URL(string: "http://lcnails.vn/api/BinhluanApi")!
        
        //Tạo đổi tượng khách hàng
        let khachHang:NSDictionary = ["Iddoituong":Iddoituong, "Noidung":Noidung, "tenNguoiBinhLuan":tenNguoiBinhLuan]
        let khachHangNoPost:NSDictionary = ["Iddoituong":Iddoituong, "Noidung":Noidung, "tenNguoiBinhLuan":tenNguoiBinhLuan,"Ngaytao": Ngaytao]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: khachHang, options: [])
        
        // print(khachHang)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            
            let httpStatus = response as? HTTPURLResponse
            if  (httpStatus != nil) {
                
                if httpStatus!.statusCode == 201
                {
                    
                    self.arrComment.append(khachHangNoPost as! [String:AnyObject])
                    
                    DispatchQueue.main.sync {
                        self.txtComment.text = ""
                        self.tableViewController.reloadData()
                        self.tableViewController.selectRow(at: IndexPath(row: self.arrComment.count - 1, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.bottom)
                    }
                    
                    return
                }
                else
                {
                    DispatchQueue.main.sync {
                        self.ThongBao(noiDung: "Bạn vui lòng thử lại")
                    }
                    
                }
            }else{
                DispatchQueue.main.sync {
                    self.ThongBao(noiDung: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                    return
                }
                
            }
            
            
        }
        
        
        task.resume()
        
    }
    
    
    func LayKyDangKyTheoThoiGian() -> String{
        //GET DATE
        let toDay = Date()
        let fomatDate = DateFormatter()
        fomatDate.dateFormat = "dd-MM-yyyy hh:MM:ss"
        return (fomatDate.string(from: toDay))
    }
}
