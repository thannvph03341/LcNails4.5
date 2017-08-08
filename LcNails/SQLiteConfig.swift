//
//  SQLiteConfig.swift
//  LcNails
//
//  Created by Lam Tung on 11/21/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import Foundation


public class SQLiteConfig{
    
    //Tên TABLE
    let NAME_TABLE_KHACH_HANG:String = "tb_users"
    let NAME_TABLE_RO_HANG:String = "tb_rohang"
    let NAME_TABLE_DON_HANG:String = "tb_donghang"
    let NAME_TABLE_SAN_PHAM:String = "tb_sanpham"
    let NAME_TABLE_NHOM_SAN_PHAM:String = "tb_nhomSanPham"
    let NAME_TABLE_NHOM_tbNhomSanPhamCon:String = "tbNhomSanPhamCon"
    let NAME_TABLE_THONG_BAO = "tbThongBaoTheoNhom"
    let NAME_TABLE_CAI_DAT = "tbCaiDat"
    
    //Tên Cột tb_users
    let KEY_STT_KHACH_HANG:String = "STT"
    let KEY_MA_KHACH_HANG:String = "maKhachHang"
    let KEY_PASSWORD:String = "matKhau"
    let KEY_LOAI_KHACH_HANG:String = "loaiKhachHang"
    let KEY_TEN_KHACH_HANG:String = "tenKhachHang"
    let KEY_GIOI_TINH:String = "gioiTinh"
    let KEY_SDT:String = "soDienThoai"
    let KEY_DIA_CHI:String = "diaChi"
    let KEY_EMAIL:String = "emailUser"
    let KEY_FACKEBOOK:String = "facebookUser"
    let KEY_WEBSITE:String = "website"
    let KEY_MA_MAY:String = "maMay"
    
    //name columns tb_rohang
    let KEY_MA_RO_HANG:String  = "maRoHang"
    let KEY_RO_HANG_MASP:String  = "maSP"
    let KEY_TEN_SP:String  = "tenSanPham"
    let KEY_GIA_SP:String  = "giaSanPham"
    let KEY_SO_LUONG:String  = "soLuong"
    let KEY_HINH_SAN_PHAM:String  = "hinhSanPham"
    let KEY_TONG_TIEN:String  = "tongTien"
    let KEY_RO_HANG_MAKHACHHANG:String  = "maKhachHang"
    
    
    //name columns tb_donhang
    let KEY_STT_DON_HANG:String  = "stt"
    let KEY_MA_DON_HANG:String  = "maDonHang"
    let KEY_DON_HANG_MASP:String  = "maSP"
    let KEY_DON_TEN_SP:String  = "tenSanPham"
    let KEY_DON_MA_KHACH_HANG:String  = "maKhachHang"
    let KEY_DON_NGAY_GIAO_DICH:String  = "ngayGiaoDich"
    let KEY_DON_GIA_SP:String  = "giaSanPham"
    let KEY_DON_SO_LUONG:String  = "soLuong"
    let KEY_DON_HINH_SAN_PHAM:String  = "hinhSanPham"
    let KEY_DON_TONG_TIEN:String  = "tongTien"
    
    // table SanPham
    let KEY_SanPham_Masanpham:String  = "Masanpham"
    let KEY_SanPham_Makhachhang:String  = "Makhachhang"
    let KEY_SanPham_Nhomsanpham:String  = "Nhomsanpham"
    let KEY_SanPham_Tensanpham:String  = "Tensanpham"
    let KEY_SanPham_Motasanoham:String  = "Motasanoham"
    let KEY_SanPham_Dongia:String  = "Dongia"
    let KEY_SanPham_Soluong:String  = "Soluong"
    let KEY_SanPham_Ngaytao:String  = "Ngaytao"
    let KEY_SanPham_Thutu:String  = "Thutu"
    let KEY_SanPham_Iconimg:String  = "Iconimg"
    let KEY_SanPham_Images:String  = "Images"
    let KEY_SanPham_maNhomSanPhamCon:String  = "maNhomSanPhamCon"
    
    // tb nhom san pham
    let KEY_NHOMSP_Nhomsanpham:String  = "Nhomsanpham"
    let KEY_NHOMSP_Tennhomsanpham:String  = "Tennhomsanpham"
    let KEY_NHOMSP_Hinhnhomsanpham:String  = "Hinhnhomsanpham"
    let KEY_NHOMSP_stt:String  = "stt"
    
    // tb Nhom San Pham Con
    let KEY_NHOM_CON_stt:String  = "stt"
    let KEY_NHOM_CON_maNhomSanPhamCon:String  = "maNhomSanPhamCon"
    let KEY_NHOM_CON_tenNhomCon:String  = "tenNhomCon"
    let KEY_NHOM_CON_Nhomsanpham:String  = "Nhomsanpham"
    let KEY_NHOM_CON_HinhnhomsanphamCon:String  = "HinhnhomsanphamCon"
    

    let Idvideo:String = "Idvideo"
    let Mota:String = "Mota"
    let Nhomsanpham:String = "Nhomsanpham"
    let Tenvideo:String = "Tenvideo"
     let imageData:String = "imageData"
    let nhomThongBao:String = "nhomThongBao"
    let ngayNhanThongBao:String = "ngayNhanThongBao"
    let noiDung:String = "noiDung"
    let tieuDe:String = "tieuDe"
    
    //tbCaiDat
    let KEY_STT_CAI_DAT = "stt"
    let KEY_KEY_CAI_DAT = "keyCAIDAT"
    let KEY_KEY_GIA_TRI = "keyGIATRI"
    
    
    
    //Nơi lưu data
    let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("nalis.db")
    var db:OpaquePointer? = nil
    
    
    
    //Mở hoặc tạo mới cơ sở dữ liệu
    func OpenOrCreateDatabase() -> String {
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            sqlite3_close(db)
            return String("Khở tại data thất bại!")
        }
        else
        {
            print("\n\npathData: " + fileUrl.path + "\n\n")
            
            return String("\n\nKhởi tạo database thành công!\n\n")
        }
    }
    
    func KhoiTaoTatCacBang() {
      
        let sql_tbThongBao:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_THONG_BAO
            + " ( " + KEY_SanPham_Masanpham + " NVARCHAR, "
            + KEY_SanPham_Makhachhang + " NVARCHAR, "
            + KEY_SanPham_Nhomsanpham + " NVARCHAR, "
            + KEY_SanPham_Tensanpham + " NVARCHAR, "
            + KEY_SanPham_Motasanoham + " NVARCHAR, "
            + KEY_SanPham_Dongia + " NVARCHAR, "
            + KEY_SanPham_Soluong + " NVARCHAR, "
            + KEY_SanPham_Ngaytao + " NVARCHAR, "
            + KEY_SanPham_Thutu + " NVARCHAR, "
            + KEY_SanPham_Iconimg + " NVARCHAR, "
            + KEY_SanPham_Images + " NVARCHAR, "
            + KEY_SanPham_maNhomSanPhamCon + " NVARCHAR, "
            + Idvideo + " NVARCHAR, "
            + Mota + " NVARCHAR, "
            + Tenvideo + " NVARCHAR, "
            + imageData + " NVARCHAR, "
            + nhomThongBao + " NVARCHAR,"
            + ngayNhanThongBao + " NVARCHAR,"
            + tieuDe + " NVARCHAR, "
            + noiDung + " NVARCHAR)"
        
       _ =  CreateTable(scriptSQL: sql_tbThongBao)

        
        //Tạo các bảng
        let sql_table_user:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_KHACH_HANG
            + " ( " + KEY_STT_KHACH_HANG + " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, "
            + KEY_MA_KHACH_HANG + " NVARCHAR, "
            + KEY_PASSWORD + " NVARCHAR, "
            + KEY_LOAI_KHACH_HANG + " NVARCHAR, "
            + KEY_TEN_KHACH_HANG + " NVARCHAR NOT NULL, "
            + KEY_GIOI_TINH + " NVARCHAR, "
            + KEY_SDT + " NVARCHAR NOT NULL, "
            + KEY_DIA_CHI + " NVARCHAR NOT NULL, "
            + KEY_EMAIL + " NVARCHAR, "
            + KEY_FACKEBOOK + " NVARCHAR, "
            + KEY_WEBSITE + " NVARCHAR, "
            + KEY_MA_MAY + " NVARCHAR "
            + " )"
        
       _ =  CreateTable(scriptSQL: sql_table_user)
        
        let sql_ro_hang:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_RO_HANG
            + " ( " + KEY_MA_RO_HANG + " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, "
            + KEY_RO_HANG_MASP + " NVARCHAR, "
            + KEY_TEN_SP + " NVARCHAR, "
            + KEY_GIA_SP + " NVARCHAR, "
            + KEY_SO_LUONG + " NVARCHAR, "
            + KEY_HINH_SAN_PHAM + " NVARCHAR, "
            + KEY_TONG_TIEN + " NVARCHAR, "
            + KEY_RO_HANG_MAKHACHHANG + " NVARCHAR "
            + " ) "
      _ =  CreateTable(scriptSQL: sql_ro_hang)
        
        let sql_don_hang:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_DON_HANG
            + " ( " + KEY_STT_DON_HANG + " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, "
            + KEY_DON_HANG_MASP + " NVARCHAR, "
            + KEY_MA_DON_HANG + " NVARCHAR, "
            + KEY_DON_MA_KHACH_HANG + " NVARCHAR, "
            + KEY_DON_TEN_SP + " NVARCHAR, "
            + KEY_DON_GIA_SP + " NVARCHAR, "
            + KEY_DON_SO_LUONG + " NVARCHAR, "
            + KEY_DON_HINH_SAN_PHAM + " NVARCHAR, "
            + KEY_DON_TONG_TIEN + " NVARCHAR, "
            + KEY_DON_NGAY_GIAO_DICH + " NVARCHAR "
            + " ) "
        
       _ =  CreateTable(scriptSQL: sql_don_hang)
        
        let sql_sanpham = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_SAN_PHAM
            + " ( " + KEY_SanPham_Masanpham + " NVARCHAR, "
            + KEY_SanPham_Makhachhang + " NVARCHAR, "
            + KEY_SanPham_Nhomsanpham + " NVARCHAR, "
            + KEY_SanPham_Tensanpham + " NVARCHAR, "
            + KEY_SanPham_Motasanoham + " NVARCHAR, "
            + KEY_SanPham_Dongia + " NVARCHAR, "
            + KEY_SanPham_Soluong + " NVARCHAR, "
            + KEY_SanPham_Ngaytao + " NVARCHAR, "
            + KEY_SanPham_Thutu + " NVARCHAR, "
            + KEY_SanPham_Iconimg + " NVARCHAR, "
            + KEY_SanPham_Images + " NVARCHAR, "
            + KEY_SanPham_maNhomSanPhamCon + " NVARCHAR "
            + " ) "
      _ =  CreateTable(scriptSQL: sql_sanpham)
        
        let sql_nhomSanPham:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_NHOM_SAN_PHAM
            + " ( "
            + KEY_NHOMSP_Nhomsanpham + " NVARCHAR, "
            + KEY_NHOMSP_Tennhomsanpham + " NVARCHAR, "
            + KEY_NHOMSP_Hinhnhomsanpham + " NVARCHAR, "
            + KEY_NHOMSP_stt + " NVARCHAR "
            + " ) "
        
      _ =  CreateTable(scriptSQL: sql_nhomSanPham)
        
        let sql_tbNhomSanPhamCon:String = "CREATE TABLE IF NOT EXISTS " + NAME_TABLE_NHOM_tbNhomSanPhamCon
            + " ( "
            + KEY_NHOM_CON_stt + " NVARCHAR, "
            + KEY_NHOM_CON_maNhomSanPhamCon + " NVARCHAR NOT NULL PRIMARY KEY UNIQUE, "
            + KEY_NHOM_CON_tenNhomCon + " NVARCHAR, "
            + KEY_NHOM_CON_Nhomsanpham + " NVARCHAR,  "
            + KEY_NHOM_CON_HinhnhomsanphamCon + " NVARCHAR " + " ) "
        
      _ =  CreateTable(scriptSQL: sql_tbNhomSanPhamCon)

      
        
        let sql_tbCaiDat:String = "CREATE TABLE IF NOT EXISTS \(NAME_TABLE_CAI_DAT)(\(KEY_STT_CAI_DAT) INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, \(KEY_KEY_CAI_DAT) NVARCHAR, \(KEY_KEY_GIA_TRI) NVARCHAR)"
       _ =  CreateTable(scriptSQL: sql_tbCaiDat)
        
    }
    
    //Tạo các bảng
    func CreateTable(scriptSQL:String) -> String{
        
        let _ = self.OpenOrCreateDatabase()
        
        if sqlite3_exec(db, scriptSQL, nil, nil, nil) != SQLITE_OK {
            sqlite3_close(db)
            return String("\n\nTạo bảng " + scriptSQL + " không thành công! \n\n")
        }
        else
        {
            sqlite3_close(db)
            return String("\n\nTạo bảng " + scriptSQL + " thành công! \n\n")
        }
    }
    
    //Tra ve thong tin khach hang
    var arrKhachHang:[KhachHangClass] = []
    func ThonTinKhachHangDatDon() -> [KhachHangClass] {
        
        let _ =  self.OpenOrCreateDatabase()
        
        if sqlite3_prepare_v2(db, "select * from tb_users", -1, &db , nil) == SQLITE_OK {
            
            while sqlite3_step(db) == SQLITE_ROW {
                //let khachHang = NSMutableDictionary()
                //print(sqlite3_column_int(db, 0))
                arrKhachHang.append(KhachHangClass(maKhachHang: String(cString: sqlite3_column_text(db, 1)), matKhau: String(cString: sqlite3_column_text(db, 2)), tenKhachHang: String(cString: sqlite3_column_text(db, 4)), soDienThoai: String(cString: sqlite3_column_text(db, 6)), diaChi: String(cString: sqlite3_column_text(db, 7)), maMay: String(cString: sqlite3_column_text(db, 11))))
                
            }
            sqlite3_finalize(db)
            sqlite3_close(db)
            return arrKhachHang
        }else{
            print("Lỗi lấy thông tin khách hàng: ",String(cString: sqlite3_errmsg(db)))
            sqlite3_finalize(db)
            sqlite3_close(db)
            return arrKhachHang
        }
        // return arrKhachHang
        
    }
    
    //Thêm Thông Tin khach hàng vào sql
    func ThemThongTinKhachHang(Makhachhang:String, Password:String, Loaikhachhang:String, Tenkhachhang:String, Gioitinh:String, Diachi:String, Sodienthoai:String, Email:String, Facebook:String, Website:String, Mamay:String) -> Bool {
        
       // print(mangKhachHang)
        
        if mangKhachHang.count != 0
        {
            mangKhachHang[0].diaChi = Diachi
            mangKhachHang[0].soDienThoai = Sodienthoai
        }
        
        let sql = "INSERT INTO tb_users values (null,'\(Makhachhang)','\(Password)','\(Loaikhachhang)','\(Tenkhachhang)','\(Gioitinh)','\(Sodienthoai)','\(Diachi)','\(Email)','\(Facebook)','\(Website)','\(Mamay)')"
        if sqlite3_exec(db, "DELETE FROM " + self.NAME_TABLE_KHACH_HANG, nil, nil, nil) == SQLITE_OK {
            if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
                if sqlite3_step(db) == SQLITE_DONE {
                    print("Thêm khách hàng thành công!")
                }
                sqlite3_finalize(db)
                sqlite3_close(db)
                return true
            }
            else{
                print("Lỗi thêm khách hàng: ", String(cString:sqlite3_errmsg(db)) )
                sqlite3_finalize(db)
                sqlite3_close(db)
                return false
            }
        }
        return false
    }
    
    
    func KiemTraThongTinKhachHang() -> Bool {
        //self.OpenOrCreateDatabase()
        if sqlite3_prepare_v2(db, "select * from tb_users ", -1, &db, nil) == SQLITE_OK {
            
            while sqlite3_step(db) == SQLITE_ROW {
                let data = String(cString: sqlite3_column_text(db, 1))
                if(data != "")
                {
                    print(data, "funnction kiểm tra thông tin!")
                    sqlite3_finalize(db)
                    sqlite3_close(db)
                    return true
                }
            }
            sqlite3_finalize(db)
            sqlite3_close(db)
        }else{
            print("Lỗi KiemTraThongTinKhachHang: ",String(cString: sqlite3_errmsg(db)))
            sqlite3_finalize(db)
            sqlite3_close(db)
            return false
        }
        
        return false
    }
    
    
    var arrSanPhamTrongRoHang:[SanPhamTrongRoHangClass] = []
    //lấy tất các sản phẩm trong rỏ hàng
    func LayTatCacSanPhamTrongRo() -> [SanPhamTrongRoHangClass]
    {
        let _ = self.OpenOrCreateDatabase()
        
        arrSanPhamTrongRoHang.removeAll()
        if sqlite3_prepare_v2(db, "SELECT * FROM tb_rohang", -1, &db, nil) == SQLITE_OK{
            while sqlite3_step(db) == SQLITE_ROW {
                
                arrSanPhamTrongRoHang.append(SanPhamTrongRoHangClass(maSanPhamTrongRo: String(cString: sqlite3_column_text(db, 0)), maSP: String(cString: sqlite3_column_text(db, 1)), tenSanPham: String(cString: sqlite3_column_text(db, 2)), giaSanPham: String(cString: sqlite3_column_text(db, 3)), soLuong: String(cString: sqlite3_column_text(db, 4)), hinhSanPham: String(cString: sqlite3_column_text(db, 5)), tongTien: String(cString: sqlite3_column_text(db, 6)), maKhachHang: String(cString: sqlite3_column_text(db, 7))))
                
                //print(arrSanPhamTrongRoHang[0].maSP)
                //arrSanPhamTrongRoHang.append(a )
                
            }
            sqlite3_finalize(db)
            sqlite3_close(db)
            return arrSanPhamTrongRoHang
        }
        sqlite3_finalize(db)
        sqlite3_close(db)
        return arrSanPhamTrongRoHang
    }
    
    func ThemThongBao(modelSanPham:ModelSanPham, modelVideo:Video, loaiThongBao:String){
        
        _ = self.OpenOrCreateDatabase()
        
        if loaiThongBao == "sanPham" {
            let sql = "INSERT INTO tbThongBaoTheoNhom (Masanpham, Makhachhang, Nhomsanpham, Tensanpham , Motasanoham, Dongia, Soluong, Ngaytao, Thutu, Iconimg, Images, maNhomSanPhamCon, Idvideo, Mota , Tenvideo , imageData, nhomThongBao, ngayNhanThongBao, tieuDe, noiDung) VALUES ('\(modelSanPham.Masanpham!)','MKH','\(modelSanPham.Nhomsanpham!)','\(modelSanPham.Tensanpham!)','\(modelSanPham.Motasanoham!)','\(modelSanPham.Dongia!)','00','00/00/0000','00','\(modelSanPham.Iconimg!)','\(modelSanPham.Images!)','\(modelSanPham.maNhomSanPhamCon!)','','','','','sanPham', '\(Date())', '\(modelSanPham.tieuDe!)', '\(modelSanPham.noiDung!)')";
            if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
                if  sqlite3_step(db) == SQLITE_DONE {
                    sqlite3_finalize(db)
                    sqlite3_close(db)
                }else{
                    
                    sqlite3_finalize(db)
                    sqlite3_close(db)
                }
            } else {
                sqlite3_finalize(db)
                sqlite3_close(db)
            }
        }
        
        if loaiThongBao == "videos" {
            let sql = "INSERT INTO tbThongBaoTheoNhom (Masanpham, Makhachhang, Nhomsanpham, Tensanpham , Motasanoham, Dongia, Soluong, Ngaytao, Thutu, Iconimg, Images, maNhomSanPhamCon, Idvideo, Mota , Tenvideo , imageData, nhomThongBao, ngayNhanThongBao, tieuDe, noiDung) VALUES ('','MKH','\(modelVideo.Nhomsanpham!)','','','','','','','','','','\(modelVideo.Idvideo!)','\(modelVideo.Mota!)','\(modelVideo.Tenvideo!)','','videos', '\(Date())','\(modelVideo.tieuDe!)', '\(modelVideo.noiDung!)')";
            if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
                if  sqlite3_step(db) == SQLITE_DONE {
                    sqlite3_finalize(db)
                    sqlite3_close(db)
                }else{
                    
                    sqlite3_finalize(db)
                    sqlite3_close(db)
                }
            } else {
                sqlite3_finalize(db)
                sqlite3_close(db)
            }
        }
    }
    
    
    func danhSachThongBao() -> [ModelThongBao]{
        let sql = "select * from tbThongBaoTheoNhom ORDER BY ngayNhanThongBao DESC"
        _ = self.OpenOrCreateDatabase()
        if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
            
            var arrTB:[ModelThongBao] = []
            while sqlite3_step(db) == SQLITE_ROW {
                let tb = ModelThongBao()
               // Masanpham, Makhachhang, Nhomsanpham, Tensanpham , Motasanoham, Dongia, Soluong, Ngaytao, Thutu, Iconimg, Images, maNhomSanPhamCon, Idvideo, Mota , Tenvideo , imageData, nhomThongBao, ngayNhanThongBao
                tb.Masanpham = String(cString: sqlite3_column_text(db, 0))
                tb.Makhachhang = String(cString: sqlite3_column_text(db, 1))
                tb.Nhomsanpham = String(cString: sqlite3_column_text(db, 2))
                tb.Tensanpham = String(cString: sqlite3_column_text(db, 3))
                tb.Motasanoham = String(cString: sqlite3_column_text(db, 4))
                tb.Dongia = sqlite3_column_double(db, 5) as NSNumber
                tb.Soluong = sqlite3_column_double(db, 6) as NSNumber
                //tb.Ngaytao = String(cString: sqlite3_column_text(db, 7))
               // tb.Thutu = String(cString: sqlite3_column_text(db, 8))
                tb.Iconimg = String(cString: sqlite3_column_text(db, 9))
                tb.Images = String(cString: sqlite3_column_text(db, 10))
                tb.maNhomSanPhamCon = String(cString: sqlite3_column_text(db, 11))
                tb.Idvideo = String(cString: sqlite3_column_text(db, 12))
                tb.Mota = String(cString: sqlite3_column_text(db, 13))
                tb.Tenvideo = String(cString: sqlite3_column_text(db, 14))
                tb.nhomThongBao = String(cString: sqlite3_column_text(db,16))
                tb.ngayNhanThongBao = String(cString: sqlite3_column_text(db, 17))
                tb.tieuDe = String(cString: sqlite3_column_text(db, 18))
                tb.noiDung = String(cString: sqlite3_column_text(db, 19))
                
                arrTB.append(tb)
                
            }
            sqlite3_finalize(db)
            sqlite3_close(db)
            return arrTB
        } else {
            return []
        }
    }
    
    //Thêm sản phẩm vào rỏ hàng
    func ThemSanPhamVaoRoHang(maRoHang:String, maSP:String, tenSanPham:String, giaSanPham:String, soLuong:String, hinhSanPham:String, tongTien:String, maKhachHang:String) -> Bool{
        
      XoaSanPhamTrongRoHangTheoMaSanPham(maSanPham: maSP)
        let _ =  self.OpenOrCreateDatabase()

        //Them san pham vao ro hang
        let sqlx:String = "INSERT INTO tb_rohang values (null,'\(maSP)','\(tenSanPham)','\(giaSanPham)','\(soLuong)','\(hinhSanPham)','\(tongTien)','\(maKhachHang)')"
        
        if sqlite3_prepare_v2(db, sqlx, -1, &db, nil) == SQLITE_OK
        {
            if  sqlite3_step(db) == SQLITE_DONE {
                print("Thêm sản phẩm vào rỏ thành công")
                sqlite3_finalize(db)
                sqlite3_close(db)
                return true
            }else{
                print("Lỗi Thực thi insert into tb_rohang: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                return false
            }
        }else{
            print("Lỗi thêm sản phẩm vào rỏ: ", String(cString: sqlite3_errmsg(db)))
            sqlite3_finalize(db)
            sqlite3_close(db)
            return false
        }
    }
    
    //Xoá sản phẩm trong rỏ hàng
    func XoaSanPhamTrongRoHang(maSanPhamTrongRo:String){
        
        let _ =  self.OpenOrCreateDatabase()
        
        let sql:String = "DELETE FROM tb_rohang WHERE maRoHang = '\(maSanPhamTrongRo)'"
        
        if sqlite3_prepare_v2(db, sql, -1, &db, nil)  == SQLITE_OK{
            if  sqlite3_step(db) == SQLITE_DONE {
                print("Xoá sản phẩm thành công!")
                sqlite3_finalize(db)
                sqlite3_close(db)
                //return true
            }else{
                print("Lỗi Thực thi xoá sản phẩm tb_rohang: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                // return false
            }
            
        }
        //sqlite3_finalize(db)
        sqlite3_close(db)
        // return false
    }
    
    //Xoá sản phẩm trong rỏ hàng
    func XoaSanPhamTrongRoHangTheoMaSanPham(maSanPham:String){
        
        let _ =  self.OpenOrCreateDatabase()
        
        let sql:String = "DELETE FROM tb_rohang WHERE maSP = '\(maSanPham)'"
        
        if sqlite3_prepare_v2(db, sql, -1, &db, nil)  == SQLITE_OK{
            if  sqlite3_step(db) == SQLITE_DONE {
                print("Xoá sản phẩm thành công!")
                sqlite3_finalize(db)
                sqlite3_close(db)
                //return true
            }else{
                print("Lỗi Thực thi xoá sản phẩm tb_rohang: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                // return false
            }
            
        }
        //sqlite3_finalize(db)
        sqlite3_close(db)
        // return false
    }
    
    
    
    //Xoá tất các sản phẩm trong rỏ hàng
    func XoaTatCacSanPhamTrongRoHang(){
        
        let _ = self.OpenOrCreateDatabase()
        let sql:String = "DELETE FROM tb_rohang"
        if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
            if sqlite3_step(db) == SQLITE_DONE {
                print("Xoá các sản phẩm trong rỏ thành công!")
                sqlite3_finalize(db)
                sqlite3_close(db)
            }else{
                print("Lỗi xoá tất các sản phẩm tb_rohang: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                
            }
        }
        
    }
    
    
    func SuaSoLuongSanPham(maSanPham:String, soLuongEdit:String, tongTien:String) -> Bool{
        
        let _ = self.OpenOrCreateDatabase()
        
        // UPDATE Customers SET ContactName='Alfred Schmidt', City='Hamburg' WHERE CustomerName='Alfreds Futterkiste';
        
        let sql:String = "UPDATE tb_rohang SET soLuong = '\(soLuongEdit)', tongTien = '\(tongTien)' WHERE maSP = '\(maSanPham)'"
        if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
            if sqlite3_step(db) == SQLITE_DONE {
                print("Sửa số lượng trong rỏ thành công!")
                sqlite3_finalize(db)
                sqlite3_close(db)
                return true
            }else{
                print("Lỗi Sửa số lượng sản phẩm tb_rohang: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                return false
            }
        }
        sqlite3_finalize(db)
        sqlite3_close(db)
        return false
    }
        
    //Xoá Ban Cai Dat
    func XoaBangCaiDat(){
        
        let _ = self.OpenOrCreateDatabase()
        let sql:String = "DELETE FROM \(NAME_TABLE_CAI_DAT)"
        if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
            if sqlite3_step(db) == SQLITE_DONE {
                print("Xoá Cai dat thành công!")
                sqlite3_finalize(db)
                sqlite3_close(db)
            }else{
                print("Lỗi xoá Cai dat: ", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(db)
                sqlite3_close(db)
                
            }
        }
        
    }
    
    func LayThoiGianDaLuu() -> String {
       _ =  self.OpenOrCreateDatabase()
        let sql:String = "SELECT * FROM tbCaiDat WHERE keyCAIDAT = 'ThoiGian'"
        if sqlite3_prepare_v2(db, sql, -1, &db, nil) == SQLITE_OK {
            var thoigian:String = ""
            
            while sqlite3_step(db) == SQLITE_ROW {
                thoigian = String(cString: sqlite3_column_text(db, 2))
            }
            
            sqlite3_finalize(db)
            sqlite3_close(db)
            return thoigian
        } else {
            print("Loi lay thoi gian: ", String(cString: sqlite3_errmsg(db)))
            sqlite3_finalize(db)
            sqlite3_close(db)
            return ""
                        
        }
    }
}

