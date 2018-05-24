//
//  ZHGPUImageStillImagesTableViewController.swift
//  AppDemo
//
//  Created by zhihua on 2018/5/23.
//  Copyright © 2018年 czh. All rights reserved.
//

import UIKit

class ZHGPUImageStillImagesTableViewController: ZHGPUTestTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func imageProcessedOnCPU(imageToProcess: UIImage) -> UIImage {
        let reslut: FilterReslut = ImageFilter.processed(onCPU: imageToProcess)
        cpuProcessingTime = reslut.useTime
        return reslut.resultImage!
    }
    
    override func imageProcessedUsingCoreImage(imageToProcess: UIImage) -> UIImage {
        let result: FilterReslut = ImageFilter.processed(onCoreImage: imageToProcess)
        coreImageProcessingTime = result.useTime
        return result.resultImage
    }
    
    override func imageProcessedUsingGPUImage(imageToProcess: UIImage) -> UIImage {
        let result: FilterReslut = ImageFilter.processed(onGpuImage: imageToProcess)
        gpuProcessingTime = result.useTime
        return result.resultImage
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
