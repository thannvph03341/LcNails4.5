//
//  Utils.swift
//  SALEAPP
//
//  Created by Lam Tung on 11/26/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    class func asyncLoadShotImage(_ shot: Sanpham, imageView : UIImageView){
        
        if shot.Iconimg==""
        {
            return
        }
        let downloadQueue = DispatchQueue(label: "com.SALEAPP.processsdownload", attributes: [])
        
        downloadQueue.async {
            
            let data = try? Data(contentsOf: URL(string: shot.Iconimg.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
            
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    class func asyncLoadMenuImage(_ shot: Nhomsanpham, imageView : UIImageView){
        
        if shot.Hinhnhomsanpham==""
        {
            imageView.image = #imageLiteral(resourceName: "logo")
            return
        }
        let downloadQueue = DispatchQueue(label: "com.SALEAPP.processsdownload", attributes: [])
        
        downloadQueue.async {
            
            let data = try? Data(contentsOf: URL(string: shot.Hinhnhomsanpham!)!)
            
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }

    class func asyncLoadVideoImage(_ shot: Video, imageView : UIImageView){
        
        if shot.Idvideo==""
        {
            return
        }
        let downloadQueue = DispatchQueue(label: "com.SALEAPP.processsdownload", attributes: [])
        
        downloadQueue.async {
            
            let data = try? Data(contentsOf: URL(string: "https://i.ytimg.com/vi/" + shot.Idvideo + "/mqdefault.jpg" )!)
            
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
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
    //    class func asyncLoadUserImage(_ user: Sanpham, imageView : UIImageView){
    //
    //        let downloadQueue = DispatchQueue(label: "com.iShots.processsdownload", attributes: [])
    //
    //        downloadQueue.async {
    //
    //            let data = try? Data(contentsOf: URL(string: user.avatarUrl)!)
    //
    //            var image : UIImage?
    //            if data != nil {
    //                image = UIImage(data: data!)!
    //                user.avatarData = data
    //            }
    //
    //            DispatchQueue.main.async {
    //                imageView.image = image
    //            }
    //        }
    //    }
    
    class func getStringFromJSON(_ data: NSDictionary, key: String) -> String{
        
        //let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
    
    class func stripHTML(_ str: NSString) -> String {
        
        var stringToStrip = str
        var r = stringToStrip.range(of: "<[^>]+>", options:.regularExpression)
        while r.location != NSNotFound {
            
            stringToStrip = stringToStrip.replacingCharacters(in: r, with: "") as NSString
            r = stringToStrip.range(of: "<[^>]+>", options:.regularExpression)
        }
        
        return stringToStrip as String
    }
    
    class func formatDate(_ dateString: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: dateString)
        
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date!)
    }
    
    
}
