//
//  GetDataSlide.swift
//  LcNails
//
//  Created by Nong Than on 12/7/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation
import ImageSlideshow



class GetDataSlide {
    
   static func loadDataSlide(_ Url: String, completion: (([SlideModels]) -> Void)!) {
        
        let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url! as URL)
        var arrslideModels = [SlideModels]()
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
                            
                            var id:String
                            if ((station["Id"] as? String) != nil) {
                                id = (station["Id"] as? String)!
                            }
                            else { id = "" }
                            
                            var moTa:String
                            if ((station["Mota"] as? String) != nil) {
                                moTa = (station["Mota"] as? String)!
                            }
                            else { moTa = "" }
                            
                            var stt:String
                            if ((station["Stt"] as? String) != nil) {
                                stt = (station["Stt"] as? String)!
                            }
                            else { stt="" }
                            
                            
                            var urlAnh:String
                            if ((station["UrlAnh"] as? String) != nil) {
                                urlAnh = "http://lcnails.vn/Image/slide/" + (station["UrlAnh"] as? String)!
                                
                            }
                            else { urlAnh = "http://lcnails.vn/Image/slide/update.jpeg" }
                            
                            arrslideModels.append(SlideModels(id: id, moTa: moTa, stt: stt, urlAnh: urlAnh))
                            //self.publishers += publisher
                            //arrSlideShowQuangCao.append(AFURLSource(urlString: urlAnh)!)
                            
                            print(urlAnh)
                        }
                        
                        let priority = DispatchQueue.GlobalQueuePriority.default
                        DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                                
                                completion(arrslideModels)
                                
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
                print("get slide err :",httpStatus!.statusCode)
            }
        }
        
        
        task.resume()
        
    }
    
}
