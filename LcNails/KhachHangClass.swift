//
//  KhachHangClass.swift
//  LcNails
//
//  Created by Lam Tung on 11/26/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation
class KhachHangClass {

    var maKhachHang:String = ""
    var matKhau:String = ""
    var tenKhachHang:String = ""
    var soDienThoai:String = ""
    var diaChi:String = ""
    var maMay:String = ""

    init(maKhachHang:String, matKhau:String, tenKhachHang:String, soDienThoai:String, diaChi:String, maMay:String) {
        self.maKhachHang = maKhachHang
        self.matKhau = matKhau
        self.tenKhachHang = tenKhachHang
        self.soDienThoai = soDienThoai
        self.diaChi = diaChi
        self.maMay = maMay
    }
}
