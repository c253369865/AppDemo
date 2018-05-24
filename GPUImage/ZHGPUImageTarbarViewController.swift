//
//  ZHGPUImageTarbarViewController.swift
//  AppDemo
//
//  Created by zhihua on 2018/5/22.
//  Copyright © 2018年 czh. All rights reserved.
//

import UIKit

class ZHGPUImageTarbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tag = item.tag
        switch tag {
        case 0:
            self.title = "Still Images"
        default:
            self.title = "Video"
        }
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
