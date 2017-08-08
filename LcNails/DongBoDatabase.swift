//
//  DongBoDatabase.swift
//  LcNails
//
//  Created by Lam Tung on 11/22/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation
class DongBoDatabase {
    
    // lấy ID máy
    //let idDeviceIOS:String =  UIDevice.current.identifierForVendor!.uuidString
    
    //
    func LoadDataSanPhamCungLoai() {
        let url:URL = URL(string:  "http://lcnails.vn/api/sanphamapi")!
        
        // let url = NSURL(string: Url) //Provided JSON data on my server. i don't know how longer it is present there!.
        let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                print("Error:"," lỗi đồng bộ sản phẩm!")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    
                    let responseString = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    let arrSanPham = responseString as! [[String:AnyObject]]
                    
                    for _ in arrSanPham
                    {
                       // print(item)
                       // print(item["Images"] ?? String())
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
