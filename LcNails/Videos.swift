//
//  Videos.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation

class Videos{
    
    static func loadVideo(_ Url: String, completion: (([Video]) -> Void)!) {
        
        let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url! as URL)
        var video = [Video]()
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
                        
                        for station in stations {
                         
                            //let stringTemp = String(describing: donGia)
                            
                            var Idvideo:String
                            if ((station["Idvideo"] as? String) != nil) {
                                Idvideo = (station["Idvideo"] as? String)!
                            }
                            else { Idvideo="" }
                            
                            var Mota:String
                            if ((station["Mota"] as? String) != nil) {
                                Mota = (station["Mota"] as? String)!
                            }
                            else { Mota="" }
                            
                            var Nhomsanpham:String
                            if ((station["Nhomsanpham"] as? String) != nil) {
                                Nhomsanpham = (station["Nhomsanpham"] as? String)!
                            }
                            else { Nhomsanpham="" }
                            
                            
                            var Tenvideo:String
                            if ((station["Tenvideo"] as? String) != nil) {
                                Tenvideo = (station["Tenvideo"] as? String)!
                            }
                            else { Tenvideo="lcnails" }
                            
                            
                            
                            video.append(Video(Idvideo: Idvideo,Mota: Mota, Nhomsanpham: Nhomsanpham, Tenvideo: Tenvideo, tieuDe:"", noiDung:""))
                            //self.publishers += publisher
                            
                        }
                       
                            DispatchQueue.main.async {
                                completion(video)
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
                print("error httpstatus code is :",httpStatus!.statusCode)
            }
        }
        
        
        task.resume()
        
    }

}
