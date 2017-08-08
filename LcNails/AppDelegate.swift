//
//  AppDelegate.swift
//  LcNails
//
//  Created by Lam Tung on 11/21/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import UserNotifications
import AudioToolbox
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var showView:HomeView?
    let db:SQLiteConfig = SQLiteConfig()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
        
        let notificationType:UIUserNotificationType = [.alert, .badge, .sound]
        let notificationSetting:UIUserNotificationSettings = UIUserNotificationSettings(types: notificationType, categories: nil)
        application.registerUserNotificationSettings(notificationSetting)
        application.registerForRemoteNotifications()
//        
//        window?.makeKeyAndVisible()
        
        //window?.rootViewController = HomeView()
        application.statusBarStyle = .lightContent
      //  226	227	230
        let backgroundStatusBar:UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor(red: 226/255, green: 227/255, blue: 230/255, alpha: 1)
            return v
        }()
        window?.addSubview(backgroundStatusBar)
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : backgroundStatusBar]))
        window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : backgroundStatusBar]))
        

      
        return FBSDKApplicationDelegate.sharedInstance().application(application,  didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError: \(error)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = "\(deviceToken as NSData)".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").uppercased()
        print("DriverToken: \(token)")
        ThongBao.DangKyToken(token: token)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let status:UIApplicationState = UIApplication.shared.applicationState
        let systemSoundIDButton : SystemSoundID = 1007
        AudioServicesPlayAlertSound(SystemSoundID(systemSoundIDButton))
        
       
        
        
       
        for (k, v) in userInfo {
            if "\(k)" == "sanPham" {
                let items = v as! [String: AnyObject]
                let sanphamMode = ModelSanPham()
                
                if let ma = items["Masanpham"] as? String {
                    sanphamMode.Masanpham = ma
                } else {
                    sanphamMode.Masanpham = ""
                }
                
                
                if let gia = items["Dongia"] as? NSNumber {
                    sanphamMode.Dongia = gia
                } else {
                    sanphamMode.Dongia = 0
                }
                
                if let ten = items["Tensanpham"] as? String {
                    sanphamMode.Tensanpham = ten
                } else {
                    sanphamMode.Tensanpham = ""
                }
                
                if let like = items["SlLike"] as? NSNumber {
                    sanphamMode.SlLike = like
                } else {
                    sanphamMode.SlLike = 0
                }
                
                if let linkImage = items["Iconimg"] as? String {
                    sanphamMode.Iconimg = linkImage
                } else {
                    sanphamMode.Iconimg = "http://lcnails.vn/theme/images/logo.png"
                }
                
                if let mkh = items["Makhachhang"] as? String {
                    sanphamMode.Makhachhang = mkh
                } else {
                    sanphamMode.Makhachhang = ""
                }
                
                if let nhomsp = items["Nhomsanpham"] as? String {
                    sanphamMode.Nhomsanpham = nhomsp
                } else {
                    sanphamMode.Nhomsanpham = ""
                }
                
                if let sl = items["Soluong"] as? NSNumber {
                    sanphamMode.Soluong = sl
                } else {
                    sanphamMode.Soluong = 0
                }
                
                if let nt = items["Ngaytao"] as? String {
                    sanphamMode.Ngaytao = nt
                } else {
                    sanphamMode.Ngaytao = ""
                }
                
                if let Thutu = items["Thutu"] as? NSNumber {
                    sanphamMode.Thutu = Thutu
                } else {
                    sanphamMode.Thutu = 0
                }
                
                if let Images = items["Images"] as? String {
                    sanphamMode.Images = Images
                } else {
                    sanphamMode.Images = ""
                }
                
                if let maNhomSanPhamCon = items["maNhomSanPhamCon"] as? String {
                    sanphamMode.maNhomSanPhamCon = maNhomSanPhamCon
                } else {
                    sanphamMode.maNhomSanPhamCon = ""
                }
                
                if let Giacu = items["Giacu"] as? NSNumber {
                    sanphamMode.Giacu = Giacu
                } else {
                    sanphamMode.Giacu = 0
                }
                //
                if let Motasanoham = items["Motasanoham"] as? String {
                    sanphamMode.Motasanoham = Motasanoham
                } else {
                    sanphamMode.Motasanoham = ""
                }
                
                
                if let tieuDe = items["tieuDe"] as? String {
                    sanphamMode.tieuDe = tieuDe
                } else {
                    sanphamMode.tieuDe = ""
                }
                
                if let noiDung = items["noiDung"] as? String {
                    sanphamMode.noiDung = noiDung
                } else {
                    sanphamMode.noiDung = ""
                }
                
                
                if let Motasanoham = items["Motasanoham"] as? String {
                    sanphamMode.Motasanoham = Motasanoham
                } else {
                    sanphamMode.Motasanoham = ""
                }
                
                
                //print(sanphamMode)
                SQLiteConfig().ThemThongBao(modelSanPham: sanphamMode, modelVideo: Video(Idvideo: "", Mota: "", Nhomsanpham: "", Tenvideo:"", tieuDe: "", noiDung:""), loaiThongBao: "sanPham")
                
                if status != .active {
                    RootViewController.sanPham = sanphamMode
                }
                
            }
            if "\(k)" == "videos" {
                let jsonVideo = v as! [String:AnyObject]
                let video = Video(Idvideo: jsonVideo["Idvideo"] as! String, Mota: jsonVideo["Mota"] as! String, Nhomsanpham: jsonVideo["Nhomsanpham"] as! String, Tenvideo: jsonVideo["Tenvideo"] as! String, tieuDe: jsonVideo["tieuDe"] as! String, noiDung: jsonVideo["noiDung"] as! String)
                
                SQLiteConfig().ThemThongBao(modelSanPham: ModelSanPham(), modelVideo: video, loaiThongBao: "videos")
                
                if status != .active {
                    RootViewController.video = video
                }
            }
        }
        
        ThongBao.arrThongBao = SQLiteConfig().danhSachThongBao()
    }
    
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
       
        
//        ThongBao.layThoiGianDaLuu { (thoiGian) in
//
//            ClassObjectThongBao.loadDataThongBaoOnline(ngayLayThongBaoGanNhat: thoiGian) { (arrThongBaoMoi) in
//                ThongBao.capNhatThoiGianLayThongBao()
//                for item in arrThongBaoMoi {
//                    _ = self.db.OpenOrCreateDatabase()
//                    //print(item.titleThongBao!)
//                    self.db.ThemThongBao(objectThongBao: item)
//                }
//
//                ThongBao.LaySoThongBaoChuaDoc(loadXong: { (ints) in
//                    //AudioServicesPlayAlertSound(SystemSoundID(4095))
//                    application.applicationIconBadgeNumber = ints
//                    
//                })
//                
//            }
//        }
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       
         FBSDKAppEvents.activateApp()
       
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

    
      
       
      
    }

    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
     
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

