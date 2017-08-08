//
//  ThongTinNhaCungCapViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/27/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class ThongTinNhaCungCapViewController: UIViewController {

    
    @IBOutlet weak var txtDiaChi: UITextView!
    @IBOutlet weak var txtSoDienThoai: UITextView!
    @IBOutlet weak var txtHotlite: UITextView!
    @IBOutlet weak var txtWeb: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        ThongTinNhaCungCap()
        
//        txtSoDienThoai.dataDetectorTypes = .phoneNumber
//        //txtSoDienThoai.isEditable = false
//        
//        txtHotlite.dataDetectorTypes = .phoneNumber
        //txtHotlite.isEditable = false
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func ThongTinNhaCungCap() {
        let url:URL = URL(string:  "http://lcnails.vn/api/thongtinnhacungcapapi")!
        
        // let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," Lỗi lấy thông tin nhà cung cấp!")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            if (httpStatus != nil){
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    let arrThongTin = responseString as! [[String:AnyObject]]
                    DispatchQueue.main.sync {
                        self.txtDiaChi.text = arrThongTin[0]["diaChi"] as? String
                        self.txtSoDienThoai.text = arrThongTin[0]["soDienThoai"] as? String
                        self.txtHotlite.text = arrThongTin[0]["hotline"] as? String
                        self.txtWeb.text = arrThongTin[0]["web"] as? String
                        self.txtEmail.text = arrThongTin[0]["emails"] as? String
                    }
                    
                        print(arrThongTin[0]["diaChi"] as! String)
                        // print(item["Tennhomsanpham"] ?? String())
                    
                    
                    
                }
                else
                {
                    print("No data got from url!")
                }
            }
            else
            {
                print("error httpstatus code is :",httpStatus!.statusCode)
            }
             }else{
                // không kết nối được máy chủ thì dừng lại luôn
                return
            }
        }
        task.resume()
        
    }

}
