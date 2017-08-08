//
//  ThongBao.swift
//  LcNails
//
//  Created by Nong Than on 12/26/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class ThongBao:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    static var showView:HomeView?
    enum LoaiThongBao:String {
        case LoaiVideo = "LoaiVideo"
        case LoaiSanPham = "LoaiSanPham"
        case LoaiHot = "LoaiHot"
    }
    
   var thongBaohandel:ThongBaoDelegate?
    
    static var arrThongBao:[ModelThongBao]?{
        didSet{
            tabviewConfig.reloadData()
        }
    }
    
    static let tabviewConfig:UITableView = {
        let tb = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = UIColor.clear
        return tb
    }()
    
    
    
    let db:SQLiteConfig = SQLiteConfig()
    
    let txtTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.text = "Thông báo"
        t.textColor = UIColor.white
        t.textAlignment = .center
        return t
        
    }()
    
    override func viewDidLoad() {
        
        navigationItem.setHidesBackButton(true, animated: true)
        txtTitle.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        navigationItem.titleView = txtTitle
        
        //  view.backgroundColor = UIColor.green
        view.addSubview(ThongBao.tabviewConfig)
        ThongBao.tabviewConfig.delegate = self
        ThongBao.tabviewConfig.dataSource = self
        ThongBao.tabviewConfig.separatorStyle = .none
        ThongBao.tabviewConfig.separatorColor = UIColor.clear
        ThongBao.tabviewConfig.scrollIndicatorInsets = UIEdgeInsetsMake(10, 0, 70, 0)
        ThongBao.tabviewConfig.contentInset = UIEdgeInsetsMake(10, 0, 70, 0)
        ThongBao.tabviewConfig.showsVerticalScrollIndicator = false
        ThongBao.tabviewConfig.register(ClassCellThongBao.self, forCellReuseIdentifier: "cell")
        // tabviewConfig.si
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ThongBao.tabviewConfig]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ThongBao.tabviewConfig]))
        //
        ThongBao.arrThongBao = SQLiteConfig().danhSachThongBao()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let number = ThongBao.arrThongBao?.count{
            return number
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thongBaohandel?.NguoiDungChonThongBao(tb: (ThongBao.arrThongBao?[indexPath.row])!)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassCellThongBao
        
        if ThongBao.arrThongBao?[indexPath.row].nhomThongBao == "sanPham" {
            cell.txtTitleThongBao.text = ThongBao.arrThongBao?[indexPath.row].tieuDe
            cell.txtNoiDungThongBao.text = ThongBao.arrThongBao?[indexPath.row].noiDung
            cell.images.image = UIImage(named: "LoaiSanPham")
        }
        
        if ThongBao.arrThongBao?[indexPath.row].nhomThongBao == "videos" {
            cell.txtTitleThongBao.text = ThongBao.arrThongBao?[indexPath.row].tieuDe
            cell.txtNoiDungThongBao.text = ThongBao.arrThongBao?[indexPath.row].noiDung
            cell.images.image = UIImage(named: "LoaiVideo")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    
    static func DangKyToken(token:String) {
        
        let url:URL = URL(string: "http://lcnails.vn/api/TokenNotificationApi")!
        
        let objectToken:NSDictionary = ["Token":token, "Makhachhang":"", "LoaiMay":"IOS"]
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: objectToken, options: [])
        URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus != nil {
                if httpStatus!.statusCode == 201 {
                    print("them token thanh cong!")
                } else {
                    print("loi them token !", httpStatus!.statusCode)
                }
            }
            }.resume()
    }
    
}

class ClassCellThongBao:UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupview()
    }
    
    var images:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        //img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var txtTitleThongBao:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "Tiêu đề thông báo!"
        lb.numberOfLines = 1
        lb.textColor = UIColor(red: 1/255, green: 101/255, blue: 255/255, alpha: 1)
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    
    var txtNoiDungThongBao:UITextView = {
        let lb = UITextView()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "Nội dung thông báo!"
        lb.textColor = UIColor(red: 0/255, green: 227/255, blue: 120/255, alpha: 1)
        lb.isSelectable = false
        lb.isEditable = false
        lb.isScrollEnabled = false
        lb.textContainerInset = UIEdgeInsetsMake(-2, -3, 0, 0)
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    
    var txtTrangThai:UITextView = {
        let lb = UITextView()
        lb.font = UIFont.systemFont(ofSize: 10)
        lb.text = "Chưa Xem"
        lb.textColor = UIColor(red: 214/255, green: 52/255, blue: 249/255, alpha: 1)
        lb.isSelectable = false
        lb.isEditable = false
        lb.isScrollEnabled = false
        lb.textContainerInset = UIEdgeInsetsMake(0, -3, 0, 0)
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    
    func setupview(){
        addSubview(images)
        addSubview(txtTitleThongBao)
        addSubview(txtNoiDungThongBao)
        //addSubview(txtTrangThai)
        images.frame = CGRect(x: 5, y: 5, width: 80, height: 80)
        txtTitleThongBao.frame = CGRect(x: 95, y: 5, width: frame.width, height: 30)
        txtNoiDungThongBao.frame = CGRect(x: 95, y: 35, width: frame.width, height: 50)
        //txtTrangThai.frame = CGRect(x: 95, y: 66, width: frame.width, height: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ClassViewThongBao:UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static var showView:HomeView?
    static var arrSanPham:[ModelSanPham] = [ModelSanPham]()
    
    static var maSanPham:String?{
        didSet{
            ModelSanPham.loadDataNotifications(manSanPham: maSanPham!) { (modelSanPham, maSp) in
                arrSanPham.removeAll()
                arrSanPham = modelSanPham
                collectionViewConfig.reloadData()
            }
        }
    }
    
    static var txtTitle:String?{
        didSet{
            txtTitleThongBao.text = txtTitle
        }
    }
    
    static var txtNoiDung:String?{
        didSet{
            txtNoiDungThongBao.text = txtNoiDung
        }
    }
    
    
    let btnBack:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("< Back", for: UIControlState.normal)
        btn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        return btn
    }()
    
    static var txtTitleThongBao:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "Tiêu đề thông báo!"
        lb.numberOfLines = 1
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = UIColor(red: 1/255, green: 101/255, blue: 255/255, alpha: 1)
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    
    static var txtNoiDungThongBao:UITextView = {
        let lb = UITextView()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.text = "Nội dung thông báo! "
        lb.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        lb.isSelectable = false
        lb.isEditable = false
        lb.isScrollEnabled = false
        lb.textAlignment = .justified
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textContainerInset = UIEdgeInsetsMake(-2, -3, 0, 0)
        lb.backgroundColor = UIColor.clear
        return lb
    }()
    
    
    static let collectionViewConfig:UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.addTarget(self, action: #selector(backView), for: UIControlEvents.touchUpInside)
        view.backgroundColor = UIColor(red: 230/255, green: 231/255, blue: 233/255, alpha: 1)
        view.addSubview(btnBack)
        view.addSubview(ClassViewThongBao.txtTitleThongBao)
        view.addSubview(ClassViewThongBao.txtNoiDungThongBao)
        view.addSubview(ClassViewThongBao.collectionViewConfig)
        ClassViewThongBao.collectionViewConfig.delegate = self
        ClassViewThongBao.collectionViewConfig.dataSource = self
        ClassViewThongBao.collectionViewConfig.showsVerticalScrollIndicator = false
        ClassViewThongBao.collectionViewConfig.register(CellSanPham.self, forCellWithReuseIdentifier: "cell")
        //        ClassViewThongBao.collectionViewConfig.scrollIndicatorInsets = UIEdgeInsetsMake(10, 0, -75, 0)
        //        ClassViewThongBao.collectionViewConfig.contentInset = UIEdgeInsetsMake(10, 0, -75, 0)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : btnBack]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ClassViewThongBao.txtTitleThongBao]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ClassViewThongBao.txtNoiDungThongBao]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[v0]-6-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : ClassViewThongBao.collectionViewConfig]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0][v1]-6-[v2]-6-[v3]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : btnBack, "v1" : ClassViewThongBao.txtTitleThongBao, "v2":ClassViewThongBao.txtNoiDungThongBao, "v3": ClassViewThongBao.collectionViewConfig]))
        
        
        
    }
    
    func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClassViewThongBao.arrSanPham.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellSanPham
        cell.backgroundColor = UIColor.clear
        cell.sanPham = ClassViewThongBao.arrSanPham[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 12, height: 245)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ClassViewThongBao.showView?.startViewFolowMaSP(sp: ClassViewThongBao.arrSanPham[indexPath.item])
        MainHinhTabBarViewController.itemSelectTabbarMenu.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
    }
}


class ClassObjectThongBao:NSObject {
    var titleThongBao:String?
    var loaiThongBao:String?
    var noiDungThongBao:String?
    var id:String?
    var thoiGian:String?
    var trangThai:String?
    var idThongBao:String?
    
    static func loadDataThongBaoOnline(ngayLayThongBaoGanNhat:String, loadXong:@escaping ([ClassObjectThongBao]) -> Void){
        let url = "http://lcnails.vn/GetThongBaoByDate/\(ngayLayThongBaoGanNhat)"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if data?.count != 0 {
                do
                {
                    
                    var arrThongBao = [ClassObjectThongBao]()
                    let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                    
                    print(json)
                    for item in json as! [[String:AnyObject]]
                    {
                        let objectThongBao = ClassObjectThongBao()
                        if let title = item["tieuDe"] as? String {
                            objectThongBao.titleThongBao = title.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.titleThongBao = ""
                        }
                        
                        if let idThongBao = item["idThongBao"] as? String {
                            objectThongBao.idThongBao = idThongBao.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.idThongBao = ""
                        }
                        
                        if let loaiThongBao = item["loaiThongBao"] as? String {
                            objectThongBao.loaiThongBao = loaiThongBao.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.loaiThongBao = ""
                        }
                        
                        if let noiDungThongBao = item["noiDung"] as? String {
                            objectThongBao.noiDungThongBao = noiDungThongBao.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.noiDungThongBao = ""
                        }
                        
                        
                        if let idKemtheo = item["idKemtheo"] as? String {
                            objectThongBao.id = idKemtheo.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.id = ""
                        }
                        
                        if let ngayTao = item["ngayTao"] as? String {
                            objectThongBao.thoiGian = ngayTao.trimmingCharacters(in: .whitespaces)
                        } else {
                            objectThongBao.thoiGian = ""
                        }
                        
                        arrThongBao.append(objectThongBao)
                    }
                    
                    loadXong(arrThongBao)
                    
                } catch let err {
                    print(err)
                }
            }
            }.resume()
    }
    
}
