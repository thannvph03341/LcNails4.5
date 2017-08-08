 //
//  DangKyViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/22/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class DangKyViewController: UIViewController, UITextFieldDelegate {
    
    let db:SQLiteConfig = SQLiteConfig()
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //ID máy
    let idDeviceIOS:String =  UIDevice.current.identifierForVendor!.uuidString
    
    //id
    @IBOutlet weak var txtHoTen: UITextField!
    @IBOutlet weak var txtDiaChi: UITextField!
    @IBOutlet weak var txtSDT: UITextField!
    @IBOutlet weak var txtMatKhau: UITextField!
    @IBOutlet weak var btnView1: UIButton!
    @IBOutlet weak var btnView2: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        //Ma hoa mat khau
        txtMatKhau.isSecureTextEntry = true
        txtHoTen.delegate = self
        txtDiaChi.delegate = self
        txtSDT.delegate = self
        txtMatKhau.delegate = self
      let _ =  db.OpenOrCreateDatabase()
        //
        txtHoTen.layer .backgroundColor = UIColor.clear.cgColor
        txtHoTen.layer.cornerRadius = 10
        txtHoTen.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        txtHoTen.layer.borderColor = UIColor.blue.cgColor
        
        txtHoTen.leftView = iconLefTextFiled(txtFiled: txtHoTen, nameImage: "infoname.png")
        
        //
        txtDiaChi.layer .backgroundColor = UIColor.clear.cgColor
        txtDiaChi.layer.cornerRadius = 10
        txtDiaChi.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        txtDiaChi.layer.borderColor = UIColor.blue.cgColor
        
        txtDiaChi.leftView = iconLefTextFiled(txtFiled: txtDiaChi, nameImage: "address.png")
        
        //
        txtSDT.layer .backgroundColor = UIColor.clear.cgColor
        txtSDT.layer.cornerRadius = 10
        txtSDT.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        txtSDT.layer.borderColor = UIColor.blue.cgColor
        
        txtSDT.leftView = iconLefTextFiled(txtFiled: txtSDT, nameImage: "smartphone.png")
        
        //
        txtMatKhau.layer .backgroundColor = UIColor.clear.cgColor
        txtMatKhau.layer.cornerRadius = 10
        txtMatKhau.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        txtMatKhau.layer.borderColor = UIColor.blue.cgColor
        
        txtMatKhau.leftView = iconLefTextFiled(txtFiled: txtMatKhau, nameImage: "padlock.png")
        
        //
       // btnView1.layer .backgroundColor = UIColor.clear.cgColor
        btnView1.layer.cornerRadius = 10
        btnView1.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        btnView1.layer.borderColor = UIColor.blue.cgColor
        //
      //  btnView2.layer .backgroundColor = UIColor.clear.cgColor
        btnView2.layer.cornerRadius = 10
        btnView2.layer.borderWidth = 0.5
        // txtSdt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        btnView2.layer.borderColor = UIColor.blue.cgColor
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //load background
        loadImageBackground()
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
        UIImage(named: "bg14.jpg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
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
    
    @IBAction func btnDangKy(_ sender: Any) {
        
        if txtHoTen.text == "" {
            
            txtHoTen.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Bạn vui lòng nhập họ tên!")
            return
        }
        
        if txtDiaChi.text == "" {
            
            txtDiaChi.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Bạn vui lòng nhập địa chỉ!")
            return
        }
        
        if txtSDT.text == "" {
            
            txtSDT.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Bạn vui lòng nhập số điện thoại!")
            
            return
        }
        
        if txtMatKhau.text == "" {
            
            txtMatKhau.becomeFirstResponder()
            ThongBao(noiDungThongBao: "Bạn vui lòng nhập mật khẩu!")
            return
        }
        
        
        DangkyThanhVien(Makhachhang: LayKyDangKyTheoThoiGian(idDevice: idDeviceIOS) , Password: (txtMatKhau.text?.trimmingCharacters(in: .whitespaces))!, Loaikhachhang: "null", Tenkhachhang: (txtHoTen.text?.trimmingCharacters(in: .whitespaces))!, Gioitinh: "null", Diachi: (txtDiaChi.text?.trimmingCharacters(in: .whitespaces))!, Sodienthoai: (txtSDT.text?.trimmingCharacters(in: .whitespaces))!, Email: "null", Facebook: "null", Website: "null", Mamay: idDeviceIOS)
        
        
        
        
    }
    
    //Đăng Ký Thành Viên!
    func DangkyThanhVien(Makhachhang:String, Password:String, Loaikhachhang:String, Tenkhachhang: String, Gioitinh:String, Diachi:String, Sodienthoai:String, Email:String, Facebook:String, Website:String, Mamay:String){
        let url:URL = URL(string: "http://lcnails.vn/api/KhachhangApi".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
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
                    
                    //              .db.ThemThongTinKhachHang(Makhachhang: item["Makhachhang"] as! String, Password: item["Password"] as! String, Loaikhachhang: item["Loaikhachhang"] as! String, Tenkhachhang: item["Tenkhachhang"] as! String, Gioitinh: item["Gioitinh"] as! String, Diachi: item["Diachi"] as! String, Sodienthoai: item["Sodienthoai"] as! String, Email: item["Email"] as! String, Facebook: item["Facebook"]!as! String, Website: item["Website"] as! String, Mamay: item["Mamay"] as! String)
                    
                    if  self.db.ThemThongTinKhachHang(Makhachhang: Makhachhang , Password: Password, Loaikhachhang: Loaikhachhang, Tenkhachhang: Tenkhachhang, Gioitinh: Gioitinh, Diachi: Diachi, Sodienthoai: Sodienthoai, Email: Email, Facebook: Facebook, Website: Website, Mamay: Mamay) {
                        DispatchQueue.main.sync {
                           // self.ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
                            let layout = UICollectionViewFlowLayout()
                            self.appDelegate.window?.makeKeyAndVisible()
                            self.appDelegate.window?.rootViewController = UINavigationController(rootViewController: RootViewController(collectionViewLayout: layout))
                        }
                    }else{
                        DispatchQueue.main.sync {
                            self.ThongBao(noiDungThongBao: "Bạn vui lòng thử lại")
                        }
                    }
                    ///
                    return
                }
                else
                {
                    DispatchQueue.main.sync {
                        self.ThongBao(noiDungThongBao: "Bạn vui lòng thử lại")
                    }
                    
                }
                //            if(statusCode == 201)
                //            {
                //                self.ChuyenManHinh(idStoryboardManHinh: "IDManHinhTabBar")
                //            }
                
            }
            else {
                DispatchQueue.main.sync {
                    self.ThongBao(noiDungThongBao: "Internet không ổn định bạn vui lòng kiểm tra lại!")
                }
            }
        }
        
        
        task.resume()
        
        
        
        
    }
    
    //get Date
    
    func LayKyDangKyTheoThoiGian(idDevice:String) -> String{
        //GET DATE
        let toDay = Date()
        let fomatDate = DateFormatter()
        fomatDate.dateFormat = "ddMMyyyyhhMMss"
        return (fomatDate.string(from: toDay) + idDevice)
    }
    
    // load man hinh moi
    open func ChuyenManHinh(idStoryboardManHinh:String!) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: idStoryboardManHinh) as UIViewController
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        txtMatKhau.resignFirstResponder()
//        txtSDT.resignFirstResponder()
//        txtDiaChi.resignFirstResponder()
        return (true)
    }
}
