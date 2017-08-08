//
//  Sanpham.swift
//  LcNails
//
//  Created by Lam Tung on 11/28/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

class Sanpham {
    
    var Dongia : String!
    var Iconimg : String!
    var Images : String!
    var Masanpham : String!
    var Motasanoham :  String!
    var Nhomsanpham : String!
    var maNhomSanPhamCon: String!
    var Tensanpham : String!
    var imageData : Data?
    var splike:Int!
    //var user: User!
    //       init(data : NSDictionary){
    //
    //        let gia = NSDecimalNumber(decimal: (data["Dongia"] as! NSNumber).decimalValue)
    //
    //        self.Dongia = gia as! String
    //        self.Iconimg = Utils.getStringFromJSON(data, key: "Iconimg")
    //        self.Images = Utils.getStringFromJSON(data, key: "Images")
    //        self.Masanpham = Utils.getStringFromJSON(data, key: "Masanpham")
    //        self.Motasanoham = Utils.getStringFromJSON(data, key: "Motasanoham")
    //        self.Nhomsanpham = Utils.getStringFromJSON(data, key: "Nhomsanpham")
    //        self.maNhomSanPhamCon = Utils.getStringFromJSON(data, key: "maNhomSanPhamCon")
    //        self.Tensanpham = Utils.getStringFromJSON(data, key: "Tensanpham")
    //        //self.imageData = data["Tensanpham"] as! String
    //    }
    init(Dongia: String,Iconimg: String, Images: String, Masanpham: String, Motasanoham: String, Nhomsanpham: String, maNhomSanPhamCon: String, Tensanpham: String, SpLike:Int)
    {
        self.Dongia = Dongia
        self.Iconimg = Iconimg
        self.Images = Images
        self.Masanpham = Masanpham
        self.Motasanoham = Motasanoham
        self.Nhomsanpham = Nhomsanpham
        self.maNhomSanPhamCon = maNhomSanPhamCon
        self.Tensanpham = Tensanpham
        self.splike = SpLike
    }
}
