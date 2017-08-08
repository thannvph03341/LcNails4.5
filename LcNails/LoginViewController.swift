//
//  LoginViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/21/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    let db:SQLiteConfig = SQLiteConfig()
    let DongBo:DongBoDatabase = DongBoDatabase()
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //ID máy
    let idDeviceIOS:String =  UIDevice.current.identifierForVendor!.uuidString
   

    @IBOutlet var viewbg_1: UIView!
    @IBOutlet weak var viewbg2: UIView!
    @IBOutlet weak var txtSdt: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnViewDangKy: UIButton!
    @IBOutlet weak var btnViewLogin: UIButton!
    var txtDiaChiUp:UITextField = UITextField()
    var txtSoDienThoaiUp:UITextField = UITextField()

   
    @IBAction func btnDangky(_ sender: Any) {
        //ChuyenManHinh(idStoryboardManHinh: "manhinh2")
    }
    
    @IBAction func btnDangNhap(_ sender: Any) {
        
        
        if txtSdt.text == "" {
            txtSdt.becomeFirstResponder()
            ThongBao(noiDung: "Bạn cần nhập số điện thoại!")
            
            return
        }
        if txtPassword.text == "" {
            txtPassword.becomeFirstResponder()
            ThongBao(noiDung: "Bạn chưa nhập mật khẩu!")
            
            return
        }
        
        
        let url:URL = URL(string: "http://lcnails.vn/KhachhangApi/" + (txtSdt.text?.trimmingCharacters(in: .whitespaces))! + "/" + (txtPassword.text?.trimmingCharacters(in: .whitespaces))! + "/KhachHangDangNhapIOS")!
        let resquest = NSMutableURLRequest(url: url as URL)
           // resquest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: resquest as URLRequest) {data, response, err in
            guard err == nil && data != nil else{
                print("Lỗi!.....")
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
                          let _ =  self.db.OpenOrCreateDatabase()
                            for item in dataKhachHang{
                                
                                //print(item["Makhachhang"])
                                
                                if self.db.ThemThongTinKhachHang(Makhachhang: item["Makhachhang"] as! String, Password: self.txtPassword.text!.trimmingCharacters(in: .whitespaces), Loaikhachhang: item["Loaikhachhang"] as! String, Tenkhachhang: item["Tenkhachhang"] as! String, Gioitinh: item["Gioitinh"] as! String, Diachi: item["Diachi"] as! String, Sodienthoai: item["Sodienthoai"] as! String, Email: item["Email"] as! String, Facebook: item["Facebook"]!as! String, Website: item["Website"] as! String, Mamay: item["Mamay"] as! String) {
                                    DispatchQueue.main.sync {
                                        let layout = UICollectionViewFlowLayout()
                                        self.appDelegate.window?.makeKeyAndVisible()
                                        self.appDelegate.window?.rootViewController = UINavigationController(rootViewController: RootViewController(collectionViewLayout: layout))
                                    }
                                }
                            }
                            
                            
                        }else{
                            DispatchQueue.main.sync {
                                self.ThongBao(noiDung: "Số điện thoại hoặc mật khẩu không đúng!")
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
        
        
    }
    
    // load man hinh moi
    func ChuyenManHinh(idStoryboardManHinh:String!) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: idStoryboardManHinh) as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        txtDiaChiUp.delegate = self
        txtSoDienThoaiUp.delegate = self
        
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 60, y: view.frame.height - 135, width: view.frame.width - 120, height: 50)
        //loginButton.constraints = UIEdgeInsetsMake(view.frame.width - 50, 0, 0, 0)
        loginButton.delegate = self
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
            print(token)
        }
        txtPassword.isSecureTextEntry = true
        txtSdt.delegate = self
        txtPassword.delegate = self
        
        //Khởi tạo data
        //db.OpenOrCreateDatabase()
        db.KhoiTaoTatCacBang()
        //DongBo.LoadData()
        
        // làm mờ hình
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.frame = viewbg2.bounds
//        self.view.addSubview(blurEffectView)
        
       // loadImageBackground()
        viewbg2.layer .backgroundColor = UIColor.clear.cgColor
        viewbg2.layer.cornerRadius = 10
        viewbg2.layer.borderWidth = 1.5
        viewbg2.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ///
        
        //txtSdt.leftViewMode = UIEdgeInsetsMake(0, 10, 0, 0)
        txtSdt.layer .backgroundColor = UIColor.clear.cgColor
        txtSdt.layer.cornerRadius = 10
        txtSdt.layer.borderWidth = 0.5
       // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
         txtSdt.layer.borderColor = UIColor.blue.cgColor
        
        txtSdt.leftView = iconLefTextFiled(txtFiled: txtSdt, nameImage: "smartphone.png")
        //.leftView =
        
        ///
        txtPassword.layer .backgroundColor = UIColor.clear.cgColor
        txtPassword.layer.cornerRadius = 10
        txtPassword.layer.borderWidth = 0.5
        txtPassword.layer.borderColor = UIColor.blue.cgColor
        txtPassword.leftView = iconLefTextFiled(txtFiled: txtPassword, nameImage: "padlock.png")
        
        
        ///
        //btnViewLogin.layer .backgroundColor = UIColor.clear.cgColor
        btnViewLogin.layer.cornerRadius = 10
        btnViewLogin.layer.borderWidth = 0.5
        btnViewLogin.layer.borderColor = UIColor.blue.cgColor
        
        ///
        //btnViewDangKy.layer .backgroundColor = UIColor.clear.cgColor
        btnViewDangKy.layer.cornerRadius = 10
        btnViewDangKy.layer.borderWidth = 0.5
        btnViewDangKy.layer.borderColor = UIColor.blue.cgColor
        
         
       
       
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchProfile()
    {
        let parammeters = ["fields": "email,link,id,first_name,last_name,locale,gender,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me",parameters: parammeters).start { (connection, result, error) in
            if error != nil{
                
                    print(error!)
                
                return
                
            }
            
            let data:[String:AnyObject] = result as! [String : AnyObject]
            
            //let email = data["email"] as? String
            let firstname = data["first_name"] as? String
            let last_name = data["last_name"] as? String
            let gender = data["gender"] as? String
            let id = data["id"] as? String
            //let employee_number = data["employee_number"] as? String
            
            //print("employee_number", employee_number)
            
          _ = self.db.OpenOrCreateDatabase()
            
           // let link = data["link"] as? String
            self.KiemTraThongTinKhachHang(Makhachhang: id! , Password: "1", Loaikhachhang: "facebook", Tenkhachhang: last_name! + " " + firstname!, Gioitinh: gender!, Diachi: "update", Sodienthoai: "update", Email: "null", Facebook: id!, Website: id!, Mamay: self.idDeviceIOS)
           //
            
        }
        //print("Đang fetch...")
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        fetchProfile()
        print("Successfully logged in with facebook...")
    }

    
    func iconLefTextFiled(txtFiled:UITextField, nameImage:String) -> UIImageView {
        txtFiled.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        let image = UIImage(named: nameImage)
        imageView.image = image
        return imageView
    }
    
    func loadImageBackground(){
    
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg12.jpg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
       //đặt hình nền 
        loadImageBackground()
        
       let _ = db.OpenOrCreateDatabase()
        
        if db.KiemTraThongTinKhachHang() {
           /// ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
            let layout = UICollectionViewFlowLayout()
            self.appDelegate.window?.makeKeyAndVisible()
            self.appDelegate.window?.rootViewController = UINavigationController(rootViewController: RootViewController(collectionViewLayout: layout))
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    //An ban phim khi an ra ngoai man hinh
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //Đăng Ký Thành Viên!
    func DangkyThanhVien(Makhachhang:String, Password:String, Loaikhachhang:String, Tenkhachhang: String, Gioitinh:String, Diachi:String, Sodienthoai:String, Email:String, Facebook:String, Website:String, Mamay:String){
        let url:URL = URL(string: "http://lcnails.vn/api/KhachhangApi")!
        
        //Tạo đổi tượng khách hàng
        let khachHang:NSDictionary = ["Makhachhang": Makhachhang, "Password": Password, "Loaikhachhang": Loaikhachhang, "Tenkhachhang": Tenkhachhang, "Gioitinh": Gioitinh, "Diachi": Diachi, "Sodienthoai": Sodienthoai, "Email": Email, "Facebook": Facebook, "Website": Website, "Mamay": Mamay]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: khachHang, options: [])
        
        // print(khachHang)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            
            let httpStatus = response as? HTTPURLResponse
            if (httpStatus != nil) {
                if httpStatus!.statusCode == 201
                {
                    
                    print(Makhachhang, Diachi)
                    
                    if  self.db.ThemThongTinKhachHang(Makhachhang: Makhachhang , Password: Password, Loaikhachhang: Loaikhachhang, Tenkhachhang: Tenkhachhang, Gioitinh: Gioitinh, Diachi: Diachi, Sodienthoai: Sodienthoai, Email: Email, Facebook: Facebook, Website: Website, Mamay: Mamay) {
                        
                        DispatchQueue.main.sync {
                            let layout = UICollectionViewFlowLayout()
                            self.appDelegate.window?.makeKeyAndVisible()
                            self.appDelegate.window?.rootViewController = UINavigationController(rootViewController: RootViewController(collectionViewLayout: layout))
                        }
                        
                    }else{
                        DispatchQueue.main.sync {
                            self.ThongBao(noiDung: "Bạn vui lòng thử lại")
                        }
                    }
                    ///
                    return
               }

                else
                {
                    DispatchQueue.main.sync {
                        self.ThongBao(noiDung: "Bạn vui lòng thử lại!")
                    }
                    
                }
            }
            else {
                DispatchQueue.main.sync {
                    self.ThongBao(noiDung: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                }
            }
        }
        
        task.resume()
        
        
    }
    
    
    //Kiem tra thong tin khach hang
    func KiemTraThongTinKhachHang(Makhachhang:String, Password:String, Loaikhachhang:String, Tenkhachhang: String, Gioitinh:String, Diachi:String, Sodienthoai:String, Email:String, Facebook:String, Website:String, Mamay:String){
        let url:URL = URL(string: "http://lcnails.vn/KhachhangApi/" + Makhachhang + "/KhachHangDangNhapFacebook")!
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," Lỗi lấy thông tin khách hàng!")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                  
                    let check = responseString as! [Any]
                    
                    if check.count == 0 {
                        
                        self.DangkyThanhVien(Makhachhang: Makhachhang, Password: Makhachhang, Loaikhachhang: Loaikhachhang, Tenkhachhang: Tenkhachhang, Gioitinh: Gioitinh, Diachi: Diachi, Sodienthoai: Sodienthoai, Email: Email, Facebook: Facebook, Website: Website, Mamay: Mamay)
                        
                         //self.DangkyThanhVien(Makhachhang: Makhachhang , Password: Password, Loaikhachhang: Loaikhachhang, Tenkhachhang: Tenkhachhang, Gioitinh: Gioitinh, Diachi: self.txtDiaChiUp.text!, Sodienthoai: self.txtSoDienThoaiUp.text!, Email: "null", Facebook: Facebook, Website: Website, Mamay: Mamay)
                        
                        
                    } else {
                    
                        
                        let arrThongTinKhachHang = responseString as! [[String:AnyObject]]
                        
                        for items in arrThongTinKhachHang
                        {
                            print(items["Makhachhang"] as! String)
                            
                            if  self.db.ThemThongTinKhachHang(Makhachhang: items["Makhachhang"] as! String , Password: items["Password"] as! String, Loaikhachhang: items["Loaikhachhang"] as! String, Tenkhachhang: items["Tenkhachhang"] as! String, Gioitinh: items["Gioitinh"] as! String, Diachi: items["Diachi"] as! String, Sodienthoai: items["Sodienthoai"] as! String, Email: items["Email"] as! String, Facebook: items["Facebook"] as! String, Website: items["Website"] as! String, Mamay: items["Mamay"] as! String) {
                                
                                DispatchQueue.main.sync {
                                    let layout = UICollectionViewFlowLayout()
                                    self.appDelegate.window?.makeKeyAndVisible()
                                    self.appDelegate.window?.rootViewController = UINavigationController(rootViewController: RootViewController(collectionViewLayout: layout))
                               }
                                
                            }else{
                                DispatchQueue.main.sync {
                                    self.ThongBao(noiDung: "Bạn vui lòng thử lại")
                                }
                            }
                        }
                    }
                    
                }
                else
                {
                    print("lỗi lấy thông tin khách hàng from url!")
                }
            }
            else
            {
                print("lỗi lấy thông tin khách hàng :",httpStatus!.statusCode)
            }
        }
        task.resume()
        
    }
    
    
    
    
    //Thong bao
    func CapNhatThongTin(Makhachhang: String , Password: String, Loaikhachhang: String, Tenkhachhang: String, Gioitinh: String, Diachi: String, Sodienthoai: String, Email: String, Facebook: String, Website: String, Mamay: String) {
    
        let alerDialog:UIAlertController = UIAlertController(title: "Thông báo!", message: "Bạn vui lòng nhận thông tin!", preferredStyle: UIAlertControllerStyle.alert)
        
        
        alerDialog.addTextField { (diachi) in
            self.txtDiaChiUp = diachi
           // self.txtDiaChiUp.keyboardType = UIKeyboardType.
            self.txtDiaChiUp.placeholder = "Nhập địa chỉ của bạn!"
        }
        alerDialog.addTextField { (sdt) in
            self.txtSoDienThoaiUp = sdt
            self.txtSoDienThoaiUp.keyboardType = UIKeyboardType.numberPad
            self.txtSoDienThoaiUp.placeholder = "Nhập số điện thoại của bạn!"
        }
        
        
        let ActionXacNhan:UIAlertAction = UIAlertAction(title: "Xác nhận!", style: UIAlertActionStyle.default, handler: {(action) in
            if self.txtDiaChiUp.text != "" && self.txtSoDienThoaiUp.text != "" {
                
                self.DangkyThanhVien(Makhachhang: Makhachhang , Password: Password, Loaikhachhang: Loaikhachhang, Tenkhachhang: Tenkhachhang, Gioitinh: Gioitinh, Diachi: self.txtDiaChiUp.text!, Sodienthoai: self.txtSoDienThoaiUp.text!, Email: "null", Facebook: Facebook, Website: Website, Mamay: Mamay)
                
                } else {
            
                self.ThongBao(noiDung: "Bạn vui lòng nhập địa chỉ và số điện thoại!")
                
            }
        
        })
        
        alerDialog.addAction(ActionXacNhan)
        self.present(alerDialog, animated: true, completion: nil)
    }
    
    

}

