//
//  Nhomsanphams.swift
//  LcNails
//
//  Created by Lam Tung on 11/29/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation

class Nhomsanphams{
    
    func loadNhomsp(_ Url: String, completion: (([Nhomsanpham]) -> Void)!) {
        
        let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url! as URL)
        var nhomsanpham = [Nhomsanpham]()
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
                            
                            var Hinhnhomsanpham:String
                            if ((station["Hinhnhomsanpham"] as? String) != nil) {
                                Hinhnhomsanpham = (station["Hinhnhomsanpham"] as? String)!
                            }
                            else { Hinhnhomsanpham="" }
                            
                            var Nhomsanpham1:String
                            if ((station["Nhomsanpham1"] as? String) != nil) {
                                Nhomsanpham1 = (station["Nhomsanpham1"] as? String)!
                            }
                            else { Nhomsanpham1="" }
                            
                            var Tennhomsanpham:String
                            if ((station["Tennhomsanpham"] as? String) != nil) {
                                Tennhomsanpham = (station["Tennhomsanpham"] as? String)!
                            }
                            else { Tennhomsanpham="" }
                            
                            
                            var stt:String
                            if ((station["stt"] as? String) != nil) {
                                stt = (station["stt"] as? String)!
                            }
                            else { stt="lcnails" }
                            nhomsanpham.append(Nhomsanpham(Hinhnhomsanpham:Hinhnhomsanpham,Nhomsanpham1:Nhomsanpham1,Tennhomsanpham:Tennhomsanpham,stt:stt))
                            //self.publishers += publisher
                            
                            //print(Tennhomsanpham)
                        }
                        
                        let priority = DispatchQueue.GlobalQueuePriority.default
                        
                        DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                                completion(nhomsanpham)
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
                print("Api get not error :",httpStatus!.statusCode)
            }
        }
        
        
        task.resume()
        
    }
    
    
}

