//
//  Nhomsanpham.swift
//  LcNails
//
//  Created by Lam Tung on 11/29/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
class Nhomsanpham{
    var Hinhnhomsanpham: String?
    var Nhomsanpham1: String!
    var Tennhomsanpham: String!
    var stt: String!
    var imageData: Data?
    init (Hinhnhomsanpham:String,Nhomsanpham1:String,Tennhomsanpham:String,stt:String)
    {
        self.Hinhnhomsanpham = Hinhnhomsanpham
        self.Nhomsanpham1 = Nhomsanpham1
        self.Tennhomsanpham = Tennhomsanpham
        self.stt = stt
    }
}
