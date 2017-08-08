//
//  VideoTableViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/27/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow

class VideoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, YTPlayerViewDelegate {
    
    
    // http://lcnails.vn/BinhluanApi/AXUxXbfD5Js/LayBinhLuanTheoVideo
    
    let imageSldieShow = ImageSlideshow()
    
    
    @IBOutlet weak var scrollviewVideo: UIScrollView!
    @IBOutlet weak var viewControlerVideo: UIView!
    @IBOutlet weak var tabViewControler: UITableView!
    @IBOutlet weak var txtTenVideo: UILabel!
    @IBOutlet weak var btnSendView: UIButton!
    @IBOutlet weak var txtComment: UITextField!
    
    @IBOutlet weak var viewInputButtonComment: UIView!
    
    
    @IBAction func btnSend(_ sender: Any) {
        
        if txtComment.text == "" {
            
            txtComment.becomeFirstResponder()
            ThongBao(noiDung: "Nội dung comment không được trống!")
            return
        }
        GuiBinhLuan(Iddoituong: idDoituong, Noidung: txtComment.text!.trimmingCharacters(in: .whitespaces), tenNguoiBinhLuan: arrKhachHangBinh[0].tenKhachHang, Ngaytao: LayKyDangKyTheoThoiGian())
        
    }
    
    var screenManHinh:CGRect = CGRect()
    var video:String!
    var tenVideoUrl:String!
    @IBOutlet weak var videoViewPlay: YTPlayerView!
    
    var idDoituong:String = ""
    let db:SQLiteConfig = SQLiteConfig()
    var arrComment:[[String:AnyObject]] = []
    var arrKhachHangBinh:[KhachHangClass] = []
    var contenInsetScroll:UIEdgeInsets = UIEdgeInsets.zero
    var scrollContenInset:UIEdgeInsets = UIEdgeInsets.zero
    
    
    public func setData(videoData:Video){
        self.video = videoData.Idvideo!
        
        self.tenVideoUrl = videoData.Tenvideo!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //          navigationController?.navigationBar.isHidden = false
        //        navigationController?.navigationBar.isTranslucent = false
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(VideoTableViewController.goBack))
        scrollviewVideo.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        idDoituong = video
        scrollviewVideo.isScrollEnabled = false
        videoViewPlay.delegate = self
        videoViewPlay.load(withVideoId: idDoituong)
        arrKhachHangBinh = db.ThonTinKhachHangDatDon()
        tabViewControler.dataSource = self
        tabViewControler.delegate = self
        LoadDataComment(idVideo: idDoituong)
        txtComment.delegate = self
        txtTenVideo.text = tenVideoUrl
        
        //cai dat ban phim
        NotificationCenter.default.addObserver(self, selector: #selector(ShowKeyboarWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HideKeyboarWillShow), name: .UIKeyboardDidHide, object: nil)
        
    }
    
    
    func goBack() {
        // Probably want to show an activity indicator
        navigationController?.navigationBar.isTranslucent = true
        _ = self.navigationController?.popViewController(animated: true)
        
        //println("back")
        
    }
    
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoViewPlay.playVideo()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        screenManHinh = UIScreen.main.bounds
        contenInsetScroll = scrollviewVideo.contentInset
        scrollContenInset = scrollviewVideo.scrollIndicatorInsets
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return arrComment.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellComment", for: indexPath) as! ItemCommentVideoTableViewCell
        
        cell.txtTenNguoiBinh.text = arrComment[indexPath.row]["tenNguoiBinhLuan"] as! String!
        let timeCreate:String = arrComment[indexPath.row]["Ngaytao"] as! String!
        
        cell.txtThoiGian.text = timeCreate
        cell.txtLoiBinh.text = arrComment[indexPath.row]["Noidung"] as! String!
        
        cell.txtLoiBinh.numberOfLines = 0
        //        cell.txtLoiBinh.textAlignment = NSTextAlignment.justified
        //        cell.txtLoiBinh.sizeToFit()
        //        tableView.rowHeight = 73 + cell.txtLoiBinh.frame.height
        
        //cell.textLabel?.text = "asdadas"
        // tableView.reloadData()
        
        return cell
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
    
    
    func LoadDataComment(idVideo:String) {
        
        let url:URL = URL(string:  "http://lcnails.vn/BinhluanApi/\(idVideo)/LayBinhLuanTheoVideo")!
        
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
                        
                        self.tabViewControler.reloadData()
                        
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
                        self.tabViewControler.reloadData()
                        self.tabViewControler.selectRow(at: IndexPath(row: self.arrComment.count - 1, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.bottom)
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
    
    //
    func ThongBao(noiDung:String){
        let alerUI:UIAlertController = UIAlertController(title: "Thông báo", message: noiDung, preferredStyle: UIAlertControllerStyle.alert)
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerUI.addAction(actionOK)
        self.present(alerUI, animated: true, completion: nil)
    }
    
    //get Date
    
    func LayKyDangKyTheoThoiGian() -> String{
        //GET DATE
        let toDay = Date()
        let fomatDate = DateFormatter()
        fomatDate.dateFormat = "dd-MM-yyyy hh:MM:ss"
        return (fomatDate.string(from: toDay))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtComment.resignFirstResponder()
        
        return (true)
    }
    
}
