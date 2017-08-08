//
//  Video.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class Video{
    
    var Idvideo : String!
    var Mota : String!
    var Nhomsanpham: String!
    var Tenvideo: String!
    var imageData: Data?
    var tieuDe:String?
    var noiDung:String?
    
    //var luotThich: String!
    init(Idvideo:String,Mota:String,Nhomsanpham:String,Tenvideo:String, tieuDe:String, noiDung:String)
    {
        self.Idvideo = Idvideo
        self.Mota = Mota
        self.Nhomsanpham = Nhomsanpham
        self.Tenvideo = Tenvideo
        self.tieuDe = tieuDe
        self.noiDung = noiDung
    }
}
