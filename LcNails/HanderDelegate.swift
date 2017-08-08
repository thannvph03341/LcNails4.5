//
//  HanderDelegate.swift
//  LcNails
//
//  Created by Nong Than on 4/21/17.
//  Copyright © 2017 DATAVIET. All rights reserved.
//

import UIKit

protocol SanPhamDelegate {
    mutating func SanPhamClick(sanPham:ModelSanPham)
}

protocol VideoMainMenuDelegate {
    mutating func NguoiDungChonVideoMenu(videoModel: Video)
}

protocol XemThemSanPhamDelegate {
    mutating func NguoiDungXemSanPhamCungLoaiNhomCha(nhomSanPhamCha:Nhomsanpham)
    mutating func NguoiDungXemSanPhamCungLoaiNhomCon(nhomCon:ModelNhomSanPhamTheoNhomCha)
}

protocol TabMenuSelector {
    mutating func IndexTabSelector(index:Int)
}


protocol NguoiDungChonMenuNhomSanPhamDelegate {
    mutating func NguoiDungChonMenuNhomSan(modelNhomSanPham:Nhomsanpham, colectionMenu:[Int:UICollectionView])
}

protocol ThongBaoDelegate {
    
    mutating func NguoiDungChonThongBao(tb:ModelThongBao)
}
