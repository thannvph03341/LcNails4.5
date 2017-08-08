//
//  VideoView.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import ImageSlideshow

var loadVideoFolowMenu: UICollectionView!

class VideoView: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate  {
    
    let imageSlide = ImageSlideshow()
    
    var refeshControl:UIRefreshControl!
    @IBOutlet weak var scrollViewControll: UIScrollView!
    @IBOutlet weak var videoLayout: UICollectionViewFlowLayout!
    @IBOutlet var videoscollection: UICollectionView!
    @IBOutlet weak var collectionViewMenu: UICollectionView!
    
    
    //var layoutMenu: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    var cellHeight : CGFloat = 240
    var screenManHinh:CGRect = CGRect()
    var video :[Video]!
    var videoNewArray:[Video] = []
    var api : Videos!
    var arrNhomVideo:[ClassNhomVideo] = [ClassNhomVideo]()
    
    let txtTitle:UILabel = {
        let t = UILabel(frame: .zero)
        t.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/20)
        t.text = "Video"
        t.textColor = UIColor.white
        t.textAlignment = .center
        return t
    }()
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        txtTitle.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        navigationItem.titleView = txtTitle
        
        
        refeshControl = UIRefreshControl()
        videoscollection.delegate = self
        videoscollection.dataSource = self
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        //collectionViewMenu.s
        collectionViewMenu.showsHorizontalScrollIndicator = false
        videoscollection.showsVerticalScrollIndicator = false
        let cellWidth = calcCellWidth(self.view.frame.size)
        cellHeight = cellWidth * 3/4
        videoLayout.itemSize = CGSize(width: cellWidth , height: cellHeight )
        
        let url = "http://lcnails.vn/api/videoapi"
        self.video = [Video]()
        self.api = Videos()
        Videos.loadVideo(url, completion: didLoadShots)
        
        //////
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //slide
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeView.didTap))
        imageSlide.setImageInputs(arrSlideShowQuangCao)
        
        //CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2.5)
        
        imageSlide.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.width/2.5)
        imageSlide.contentScaleMode = UIViewContentMode.scaleToFill
        imageSlide.slideshowInterval = 2
        imageSlide.addGestureRecognizer(gestureRecognizer)
        
        scrollViewControll.addSubview(imageSlide)
        
        //scrollViewControll.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 50)
        
        refeshControl.addTarget(self, action: #selector(loadrefeshData), for: UIControlEvents.valueChanged)
        videoscollection.insertSubview(refeshControl, at: 0)
        
        //
        
        
        ClassNhomVideo.getNhomVideo { (arrNhomVideos) in
            //print(arrNhomVideo.count)
            self.arrNhomVideo = arrNhomVideos
            self.collectionViewMenu.reloadData()
        }
        
        
        GetDataSlide.loadDataSlide("http://lcnails.vn/api/slideapi") { (slide) in
            var array:[AFURLSource] = []
            for items in slide {
                array.append(AFURLSource(urlString: items.urlAnh)!)
            }
            
            self.imageSlide.setImageInputs(array)
            
        }
        
    }
    
    
    func loadrefeshData() {
        refeshControl.endRefreshing()
        
        ClassNhomVideo.getNhomVideo { (arrNhomVideos) in
            //print(arrNhomVideo.count)
            self.arrNhomVideo = arrNhomVideos
            self.collectionViewMenu.reloadData()
        }
        
        
        let url = "http://lcnails.vn/api/videoapi"
        self.video = [Video]()
        self.api = Videos()
        Videos.loadVideo(url, completion: didLoadShots)
        
        
    }
    
    
    
    
    func calcCellWidth(_ size: CGSize) -> CGFloat {
        let transitionToWide = size.width > size.height
        var cellWidth = size.width
        
        if transitionToWide {
            cellWidth = size.width / 2
        }
        
        return cellWidth
    }
    
    
    // cham vao view full anh
    func didTap() {
        imageSlide.presentFullScreenController(from: self)
    }
    
    
    func didLoadShots(_ loadedShots: [Video]){
        
        
        for shot in loadedShots {
            self.video.append(shot)
        }
        
        videoscollection.reloadData()
    }
    
    func didLoadShotsLoadVideoFolowNhom(_ loadedShots: [Video]){
        
        self.video = []
        
        for shot in loadedShots {
            self.video.append(shot)
        }
        videoscollection.reloadData()
        
        
        
    }
    
    
    func loadNewVideo(maNhom:String){
        
        if maNhom != "all" {
            let url = "http://lcnails.vn/VideoApi/" + maNhom + "/LayVideoTheoNhomSanPham"
            self.video = [Video]()
            self.api = Videos()
            Videos.loadVideo(url, completion: didLoadShotsLoadVideoFolowNhom)
        } else {
            let url = "http://lcnails.vn/api/videoapi"
            self.video = [Video]()
            self.api = Videos()
            Videos.loadVideo(url, completion: didLoadShots)
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == videoscollection {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCells", for: indexPath) as! VideosCollectionViewCell
            let videoct = video[indexPath.row]
            
            
            // cell.frame.size = CGSize(width: screenManHinh.width, height: cell.frame.height)
            //cell.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            cell.videoLabel.text = videoct.Tenvideo
            //cell.tensanphamLabel.text = sanphamct.Tensanpham
            cell.videoImg.image = nil
            Utils.asyncLoadVideoImage(videoct, imageView: cell.videoImg)
            cell.layer.borderColor = UIColor.blue.cgColor
            cell.layer.borderWidth = 0.5
            cell.layer.cornerRadius = 5
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMenu", for: indexPath) as! MenuVideoCell
            //Utils.asyncLoadMenuImage(arrNhomVideo[indexPath.row].Hinhnhomsanpham!, imageView: cell.ImageVideoMenu)
            cell.ImageVideoMenu.LoadImageUrlString(urlString: arrNhomVideo[indexPath.row].Hinhnhomsanpham!)
            cell.txtTen.text = arrNhomVideo[indexPath.row].Tennhomvideo
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == videoscollection {
            
            performSegue(withIdentifier: "showvideo", sender: self)
        } else {
            loadNewVideo(maNhom: arrNhomVideo[indexPath.row].Manhomvideo!)
            //loadNewVideo(maNhom: "dan")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showvideo"){
            
            let selectedItems = videoscollection.indexPathsForSelectedItems
            
            if let sItem = selectedItems as [IndexPath]!{
                let shot = video[sItem[0].row]
                let controller = segue.destination as! VideoTableViewController
                controller.video = shot.Idvideo
                controller.tenVideoUrl = shot.Tenvideo
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == videoscollection {
            return video.count
        } else {
            return arrNhomVideo.count
        }
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //😂😜😳.removeAll()
    }
    
    
    override public func viewDidAppear(_ animated: Bool) {
        screenManHinh = UIScreen.main.bounds
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



class ClassNhomVideo:NSObject {
    
    var Manhomvideo:String?
    var Tennhomvideo:String?
    var Hinhnhomsanpham:String?
    var stt:NSNumber?
    
    static func getNhomVideo(loadXong: @escaping ([ClassNhomVideo]) -> Void){
        
        let url = "http://lcnails.vn/api/NhomvideosApi"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                var arrNhomVideo = [ClassNhomVideo]()
                for item in json as! [[String:AnyObject]] {
                    let nhomVideo = ClassNhomVideo()
                    if let Manhomvideo = item["Manhomvideo"] as? String {
                        nhomVideo.Manhomvideo = Manhomvideo
                    } else {
                        nhomVideo.Manhomvideo = ""
                    }
                    
                    if let Tennhomvideo = item["Tennhomvideo"] as? String {
                        nhomVideo.Tennhomvideo = Tennhomvideo
                    } else {
                        nhomVideo.Tennhomvideo = ""
                    }
                    
                    if let Hinhnhomsanpham = item["Hinhnhomsanpham"] as? String {
                        nhomVideo.Hinhnhomsanpham = Hinhnhomsanpham
                    } else {
                        nhomVideo.Hinhnhomsanpham = "http://lcnails.vn/theme/images/logo_Nail.png"
                    }
                    
                    if let stt = item["stt"] as? NSNumber {
                        nhomVideo.stt = stt
                    } else {
                        nhomVideo.stt = -1
                    }
                    
                    arrNhomVideo.append(nhomVideo)
                }
                
                DispatchQueue.main.async(execute: {() -> Void in
                    loadXong(arrNhomVideo)
                })
                
            } catch let err {
                
                print(err)
            }
            
            }.resume()
        
    }
    
}
