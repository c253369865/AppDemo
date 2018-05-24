//
//  ZHGPUTestTableViewController.swift
//  AppDemo
//
//  Created by zhihua on 2018/5/22.
//  Copyright © 2018年 czh. All rights reserved.
//

import UIKit

enum FilterType: Int {
    case cpu = 0
    case coreImage
    case gpuImage
}

class ZHGPUTestTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var cpuProcessingTime: CGFloat = 0
    var coreImageProcessingTime: CGFloat = 0
    var gpuProcessingTime: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        addFilterBtn()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
//    func addFilterBtn() {
//        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 60))
//        
//        let btn = UIButton(type: .roundedRect)
//        btn.frame = CGRect(x: 60, y: 20, width: 200, height: 40)
//        btn.setTitle("Begin Filter", for: .normal)
//        btn.addTarget(self, action: #selector(beginFilter), for: .touchUpInside)
//        
//        self.tableView.tableHeaderView?.addSubview(btn)
//    }
    
    func beginFilter() {
        print("abc")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        let filterType = FilterType(rawValue: indexPath.row)!
        switch filterType {
        case .cpu:
            cell?.textLabel?.text = "CPU"
            cell?.detailTextLabel?.text = String(format: "%.1fms", cpuProcessingTime)
        case .coreImage:
            cell?.textLabel?.text = "Core Image"
            cell?.detailTextLabel?.text = String(format: "%.1fms", coreImageProcessingTime)
        case .gpuImage:
            cell?.textLabel?.text = "GPUImage"
            cell?.detailTextLabel?.text = String(format: "%.1fms", gpuProcessingTime)
        }

        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = UIImage(named: "Lambeau")
        var reslutImage: UIImage?
        let filterType = FilterType(rawValue: indexPath.row)!
        switch filterType {
        case .cpu:
            reslutImage = imageProcessedOnCPU(imageToProcess: image!)
            reslutImage = nil
        case .coreImage:
            reslutImage = imageProcessedUsingCoreImage(imageToProcess: image!)
        case .gpuImage:
            reslutImage = imageProcessedUsingGPUImage(imageToProcess: image!)
        }
        if (reslutImage != nil) {
            self.bgImageView.image = reslutImage
        } else {
            self.bgImageView.image = image
        }
        
        
        self.tableView.reloadData()
    }
    
    // Mark: - Images Process
    func imageProcessedOnCPU(imageToProcess: UIImage) -> UIImage {
        return imageToProcess
    }
    
    func imageProcessedUsingCoreImage(imageToProcess: UIImage) -> UIImage {
        return imageToProcess
    }
    
    func imageProcessedUsingGPUImage(imageToProcess: UIImage) -> UIImage {
        return imageToProcess
    }
    
    func writeImageToFile(imageToWrite: UIImage, fileName: String) {
        
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
