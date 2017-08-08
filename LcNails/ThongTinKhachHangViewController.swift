//
//  ThongTinKhachHangViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/27/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class ThongTinKhachHangViewController: UIViewController, UITextFieldDelegate {
    
    var screenManHinh:CGRect = CGRect()
    var framescrollView:CGRect = CGRect()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtHoTen: UITextField!
    @IBOutlet weak var txtDiaChi: UITextField!
    @IBOutlet weak var txtSDT: UITextField!
    @IBOutlet weak var txtMatKhau: UITextField!
    @IBOutlet weak var btnSuaThongTinView: UIButton!
    @IBOutlet weak var btnThongTinNhaCungCap: UIButton!
    
    @IBAction func btnViewTabNhaCungCap(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let thongTinNhaCP = story.instantiateViewController(withIdentifier: "ThongTinNhaCungCap") as! ThongTinNhaCungCapViewController
        self.navigationController?.pushViewController(thongTinNhaCP, animated: true)
        
    }
    let db:SQLiteConfig = SQLiteConfig()
    var arrKH:[KhachHangClass] = []
    var check:Bool = false
    
    
    let txtTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.text = "Thông tin"
        t.textColor = UIColor.white
        t.textAlignment = .center
        return t
        
    }()
    
    
    @IBOutlet weak var btnTextSuaThongTin: UIButton!
    @IBAction func btnSuaThongTin(_ sender: Any) {
        
        // check = !check
        if check {
            
            txtHoTen.isEnabled = false
            txtDiaChi.isEnabled = false
            txtSDT.isEnabled = false
            txtMatKhau.isEnabled = false
            
            txtHoTen.borderStyle = UITextBorderStyle.none
            txtSDT.borderStyle = UITextBorderStyle.none
            txtDiaChi.borderStyle = UITextBorderStyle.none
            txtMatKhau.borderStyle = UITextBorderStyle.none
            btnTextSuaThongTin.titleLabel?.text = "Sửa thông tin!"
            
            check = !check
        }else{
            txtHoTen.isEnabled = true
            txtDiaChi.isEnabled = true
            txtSDT.isEnabled = true
            txtMatKhau.isEnabled = true
            
            txtHoTen.borderStyle = UITextBorderStyle.bezel
            txtSDT.borderStyle = UITextBorderStyle.bezel
            txtDiaChi.borderStyle = UITextBorderStyle.bezel
            txtMatKhau.borderStyle = UITextBorderStyle.bezel
            btnTextSuaThongTin.titleLabel?.text = "Cập nhật thông tin!"
            check = !check
            return
        }
        
        if txtHoTen.text == "" {
            txtHoTen.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Họ tên không được để trống!")
            return
        }
        
        if txtDiaChi.text == "" {
            txtDiaChi.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Địa chỉ không được để trống!")
            return
        }
        
        if txtSDT.text == "" {
            txtSDT.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Số điện thoại không được để trống!")
            return
        }
        
        if txtSDT.text!.characters.count > 15 ||  txtSDT.text!.characters.count < 6{
            ThongBao(noiDung: "Số điện thoại không chính xác!")
            return
        }
        
        
        if txtMatKhau.text == "" {
            txtMatKhau.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Mật khẩu không được để trống!")
            return
        }
        
        
        CapNhatThongTin(Makhachhang: arrKH[0].maKhachHang, Password: txtMatKhau.text!,Tenkhachhang: txtHoTen.text!, Diachi: txtDiaChi.text!, Sodienthoai: txtSDT.text!)
        
        
    }
    //kiem tra so dien thoai
    func isValidPhone(phone: String) -> Bool {
        let PHONE_REGEX:String = "(\\+84|08|098|097|096|0169|0168|0167|0166|0165|0164|0163|0162|090|093|0122|0126|0128|0121|0120|091|094|0123|0124|0125|0127|0129|092|0188|0186|099|0199)\\d{6,10}"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phone)
        return result
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        txtTitle.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        navigationItem.titleView = txtTitle
        
        //navigationItem.setHidesBackButton(true, animated: true)
        txtHoTen.isEnabled = false
        txtDiaChi.isEnabled = false
        txtSDT.isEnabled = false
        txtMatKhau.isEnabled = false
        txtHoTen.delegate = self
        txtDiaChi.delegate = self
        txtSDT.delegate = self
        txtMatKhau.delegate = self
        txtMatKhau.isSecureTextEntry = true
        arrKH = db.ThonTinKhachHangDatDon()
        
        txtHoTen.text = arrKH[0].tenKhachHang
        txtDiaChi.text = arrKH[0].diaChi
        txtSDT.text = arrKH[0].soDienThoai
        txtMatKhau.text = arrKH[0].matKhau
        
        
        ///
        btnSuaThongTinView.layer.borderColor = UIColor.blue.cgColor
        btnSuaThongTinView.layer.cornerRadius = 5
        btnSuaThongTinView.layer.borderWidth = 0.5
        
        
        ///
        btnThongTinNhaCungCap.layer.borderColor = UIColor.blue.cgColor
        btnThongTinNhaCungCap.layer.cornerRadius = 5
        btnThongTinNhaCungCap.layer.borderWidth = 0.5
        ///
        txtHoTen.layer.borderColor = UIColor.blue.cgColor
        txtHoTen.layer.cornerRadius = 5
        txtHoTen.layer.borderWidth = 0.5
        txtHoTen.leftView = iconLefTextFiled(txtFiled: txtHoTen, nameImage: "infoname.png")
        ///
        txtDiaChi.layer.borderColor = UIColor.blue.cgColor
        txtDiaChi.layer.cornerRadius = 5
        txtDiaChi.layer.borderWidth = 0.5
        txtDiaChi.leftView = iconLefTextFiled(txtFiled: txtDiaChi, nameImage: "address.png")
        ///
        txtMatKhau.layer.borderColor = UIColor.blue.cgColor
        txtMatKhau.layer.cornerRadius = 5
        txtMatKhau.layer.borderWidth = 0.5
        txtMatKhau.leftView = iconLefTextFiled(txtFiled: txtMatKhau, nameImage: "padlock.png")
        ///
        txtSDT.layer.borderColor = UIColor.blue.cgColor
        txtSDT.layer.cornerRadius = 5
        txtSDT.layer.borderWidth = 0.5
        txtSDT.leftView = iconLefTextFiled(txtFiled: txtSDT, nameImage: "smartphone.png")
        
        
        
        //Dịch o nhập lên khi mở bàn phím
        NotificationCenter.default.addObserver(self, selector: #selector(ThongTinKhachHangViewController.keyBoardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ThongTinKhachHangViewController.keyBoarHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        screenManHinh = UIScreen.main.bounds
        framescrollView = scrollView.frame
    }
    
    
    func iconLefTextFiled(txtFiled:UITextField, nameImage:String) -> UIImageView {
        txtFiled.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        let image = UIImage(named: nameImage)
        imageView.image = image
        return imageView
    }
    
    
    func keyBoardDidShow(notification :NSNotification)
    {
        if let frameObject: AnyObject = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
        {
            let keyboardRect = frameObject.cgRectValue
            
            //            -txtComment-  (16.0, 482.0, 240.0, 30.0)
            //            -keyboardRect-  (0.0, 352.0, 320.0, 216.0)
            //btn (269.0, 481.0, 36.0, 30.0)
            // dgndf,.
            print(self.view.frame)
            //scrollView.frame.size = CGSize(width: 320.0, height: 230.0)
            if screenManHinh.height < 736 {
                scrollView.frame = CGRect(x: 0.0, y: 0 - (keyboardRect?.height)!/2 , width: screenManHinh.width, height: screenManHinh.height)
            }
            // txtComment.frame = CGRect(x: 16.0, y:(screenManHinh.height - (keyboardRect?.height)!) - 30, width: 240.0, height: 30.0)
            //print("-txtComment- ",txtComment.frame)
            //print("-keyboardRect- ", keyboardRect!)
            
            //self.view.s
            //txtComment.removeFromSuperview()
        }
    }
    
    func keyBoarHide(notification:NSNotification){
        
        if let frameObject: AnyObject = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject?
        {
            let _ = frameObject.cgRectValue
            
            scrollView.frame = framescrollView
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func ThongBao(noiDungThongBao:String) {
        let aler = UIAlertController(title: "Thông báo", message: noiDungThongBao, preferredStyle: UIAlertControllerStyle.alert)
        let alerAction  = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        aler.addAction(alerAction)
        self.present(aler, animated: true, completion: nil)
        
        
    }
    
    //Cập nhật thông tin khách hàng
    func CapNhatThongTin(Makhachhang:String, Password:String, Tenkhachhang: String, Diachi:String, Sodienthoai:String){
        let url:URL = URL(string: "http://lcnails.vn/api/KhachhangApi/CapNhatThongTinKhachHang")!
        
        //Tạo đổi tượng khách hàng
        let khachHang:NSDictionary = ["Makhachhang": Makhachhang.trimmingCharacters(in: .whitespaces), "Password": Password.trimmingCharacters(in: .whitespaces), "Tenkhachhang": Tenkhachhang.trimmingCharacters(in: .whitespaces), "Diachi": Diachi.trimmingCharacters(in: .whitespaces), "Sodienthoai": Sodienthoai.trimmingCharacters(in: .whitespaces)]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: khachHang, options: [])
        
        print(khachHang)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            
            let httpStatus = response as? HTTPURLResponse
            
            if (httpStatus != nil ) {
                
                if httpStatus!.statusCode == 201 || httpStatus!.statusCode == 200
                {
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    // let arrNhomSanPham = responseString as! [String]
                    // print(responseString)
                    ///
                    DispatchQueue.main.sync {
                        ////////
                        
                        let url:URL = URL(string: "http://lcnails.vn/KhachhangApi/" + Sodienthoai + "/" + Password + "/KhachHangDangNhapIOS")!
                        let resquest = NSMutableURLRequest(url: url as URL)
                        // resquest.httpMethod = "GET"
                        let task = URLSession.shared.dataTask(with: resquest as URLRequest) {data, response, err in
                            guard err == nil && data != nil else{
                                print("Lỗi!..cập nhật thông tin...")
                                return
                            }
                            
                            let httpStatus = response as? HTTPURLResponse
                            if (httpStatus != nil){
                                if httpStatus!.statusCode == 200
                                    
                                {
                                    if data?.count != 0
                                    {
                                        let dataObject = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                        let dataKhachHang = dataObject as! [[String:AnyObject]]
                                        //let check:NSString = dataKhachHang[0] as! NSString
                                        
                                        if( dataKhachHang.count != 0) {
                                            _ = self.db.OpenOrCreateDatabase()
                                            for item in dataKhachHang{
                                                
                                                //print(item["Makhachhang"])
                                                
                                                if self.db.ThemThongTinKhachHang(Makhachhang: item["Makhachhang"] as! String, Password: Password, Loaikhachhang: item["Loaikhachhang"] as! String, Tenkhachhang: item["Tenkhachhang"] as! String, Gioitinh: item["Gioitinh"] as! String, Diachi: item["Diachi"] as! String, Sodienthoai: item["Sodienthoai"] as! String, Email: item["Email"] as! String, Facebook: item["Facebook"]!as! String, Website: item["Website"] as! String, Mamay: item["Mamay"] as! String) {
                                                    DispatchQueue.main.sync {
                                                        self.ThongBao(noiDungThongBao: String(describing: responseString))
                                                    }
                                                }
                                            }
                                            
                                            
                                        }else{
                                            DispatchQueue.main.sync {
                                                self.ThongBao(noiDung: "Lỗi cập nhật thông tin!")
                                            }
                                            return
                                        }
                                        
                                    }
                                }
                                else
                                {
                                    print("Lỗi kết nối: ", httpStatus!.statusCode)
                                }
                            } else {
                                DispatchQueue.main.sync {
                                    self.ThongBao(noiDung: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                                }
                            }
                        }
                        task.resume()
                        
                        
                        ////
                        
                    }
                    return
                }
                else
                {
                    print("error httpstatus code is :",httpStatus!.statusCode)
                    
                }
                //            if(statusCode == 201)
                //            {
                //                self.ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
                //            }
                
            }else {
                DispatchQueue.main.sync {
                    self.ThongBao(noiDungThongBao: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                    return
                }
            }
            
        }
        task.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
}
