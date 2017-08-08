//
//  CheckVersionStore.swift
//  LcNails
//
//  Created by Nong Than on 4/25/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

class ClassCheckVersion:NSObject {
    var version:String?
    
    
    static func getVersion(loadXong: @escaping (Bool) -> Void) {
        let url = "http://itunes.apple.com/lookup?bundleId=dataviet.vn.lcnails"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            do
            {
                
                // version có trên appstore
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                let dataJson = json as AnyObject
                let arrJson =  dataJson["results"] as! [AnyObject]
                let versionAppInStrore = arrJson[0]["version"]!! as! String
                print("version on store:", versionAppInStrore)
                //// version của app
                let versionInApp = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                print("version on app:", versionInApp)
                
                if Double(versionAppInStrore)! > Double(versionInApp)! {
                    loadXong(true)
                } else {
                    loadXong(false)
                }
                
                
                //                for items in arrJson as? AnyObject{
                //                    print(items["version"])
                //                }
                //for item in json as! []
            }catch let err {
                print(err)
            }
            
            
            }.resume()
    }
    
}




