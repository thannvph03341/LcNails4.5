//
//  MainHinhTabBarViewController.swift
//  LcNails
//
//  Created by Lam Tung on 11/22/16.
//  Copyright © 2016 DATAVIET. All rights reserved.
//

import UIKit

var frameTabar:CGRect = CGRect()
class MainHinhTabBarViewController: UITabBarController {
 static var itemSelectTabbarMenu:UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       MainHinhTabBarViewController.itemSelectTabbarMenu = self
        //itemSelectTabbarMenu.delegate
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        frameTabar  = tabBar.frame
       // print(navigationController?.toolbar.items?.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   public func SetTabarController() {
         selectedIndex = 3
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
