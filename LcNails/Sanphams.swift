//
//  Sanphams.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation

//var spCungLoai:[Sanpham] = []
class Sanphams {
    
    let accessToken = "dc5a71673c52e02fb510a7bf514789a90c1d9c169c13edbd92e5e19ba74a5f56"
    
    func loadShots(_ shotsUrl: String, completion: (([Sanpham]) -> Void)!) {
        
        let urlString = shotsUrl
        
        let session = URLSession.shared
        let shotsUrl = URL(string: urlString)
        
        let task = session.dataTask(with: shotsUrl!, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                
                let shots = [Sanpham]()
                do {
                    let shotsData = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                    
                    for _ in shotsData{
                        //let shot = Sanpham(data: shot as! NSDictionary)
                        //shots.append(shot)
                    }
                    
                }catch{
                    
                }
                
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    DispatchQueue.main.async {
                        completion(shots)
                    }
                }
                
            }
        })
        
        task.resume()
    }
    
    func loadSanpham(_ Url: String, completion: (([Sanpham]) -> Void)!) {
        
        let url = NSURL(string: Url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url! as URL)
        var sanpham = [Sanpham]()
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," lỗi")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let stations = responseString as? [[String: AnyObject]] {
                    //    print("dataGet",stations)
                        for station in stations {
                            var nhomsp:String
                            if ((station["Nhomsanpham"] as? String) != nil) {
                                nhomsp = (station["Nhomsanpham"] as? String)!
                            }
                            else { nhomsp="lcnails" }
                            let donGia = NSDecimalNumber(decimal: (station["Dongia"] as! NSNumber).decimalValue)
                            let Gia = self.DinhDangTien.string(from: NSNumber.init(value: Int(donGia)))
                            //let stringTemp = String(describing: donGia)
                            
                            var maSanpham:String
                            if ((station["Masanpham"] as? String) != nil) {
                                maSanpham = (station["Masanpham"] as? String)!
                            }
                            else { maSanpham="lcnails" }
                            
                            var iconImage:String
                            if ((station["Iconimg"] as? String) != nil) {
                                iconImage = (station["Iconimg"] as? String)!
                            }
                            else { iconImage="" }
                            
                            var Images:String
                            if ((station["Images"] as? String) != nil) {
                                Images = (station["Images"] as? String)!
                            }
                            else { Images="" }
                            
                            
                            var tenSanpham:String
                            if ((station["Tensanpham"] as? String) != nil) {
                                tenSanpham = (station["Tensanpham"] as? String)!
                            }
                            else { tenSanpham="lcnails" }
                            
                            var maNhomSanPhamCon:String
                            if ((station["maNhomSanPhamCon"] as? String) != nil) {
                                maNhomSanPhamCon = (station["maNhomSanPhamCon"] as? String)!
                            }
                            else { maNhomSanPhamCon="lcnails" }
                            
                            var Motasanoham:String
                            if ((station["Motasanoham"] as? String) != nil) {
                                Motasanoham = (station["Motasanoham"] as? String)!
                            }
                            else { Motasanoham="lcnails" }
                            var SlLike:Int
                           //print(station["SlLike"])
                            if ((station["SlLike"] as? Int) != nil) {
                                SlLike = (station["SlLike"] as? Int)!
                            }
                            else { SlLike = 0 }
                            
                            sanpham.append(Sanpham(Dongia: Gia!,Iconimg: iconImage, Images: Images, Masanpham: maSanpham, Motasanoham: Motasanoham, Nhomsanpham: nhomsp, maNhomSanPhamCon: maNhomSanPhamCon, Tensanpham: tenSanpham, SpLike:SlLike))
                            //self.publishers += publisher
                            
                        }
                        let priority = DispatchQueue.GlobalQueuePriority.default
                        DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                             
                                completion(sanpham)
                            }
                        }
                    }
                    
                }
                else
                {
                    print("No data got from url!")
                }
            }
            else
            {
                print("loi lay san pham :",httpStatus!.statusCode)
            }
        }
        
        
        task.resume()
        
    }
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
}
