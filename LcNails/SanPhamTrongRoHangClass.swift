//
//  SanPhamTrongRoHangClass.swift
//  LcNails
//
//  Created by Lam Tung on 11/25/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation

class SanPhamTrongRoHangClass {

    var maSanPhamTrongRo:String = ""
    var maSP:String = ""
    var tenSanPham:String = ""
    var giaSanPham:String = ""
    var soLuong:String = ""
    var hinhSanPham:String = ""
    var tongTien:String = ""
    var maKhachHang:String = ""

     /*, maSP:String, tenSanPham:String, giaSanPham:String, soLuong:String, hinhSanPham:String, tongTien:String, maKhachHang:String*/
    init(maSanPhamTrongRo:String, maSP:String, tenSanPham:String, giaSanPham:String, soLuong:String, hinhSanPham:String, tongTien:String, maKhachHang:String) {
        
        self.maSanPhamTrongRo = maSanPhamTrongRo
        self.maSP = maSP
        self.tenSanPham = tenSanPham
        self.giaSanPham = giaSanPham
        self.soLuong = soLuong
        self.hinhSanPham = hinhSanPham
        self.tongTien = tongTien
        self.maKhachHang = maKhachHang
       // self.tongTienDonHang = tongTienDonHang
        
    }
    
    
    
}
