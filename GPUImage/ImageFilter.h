//
//  ImageFilter.h
//  AppDemo
//
//  Created by zhihua on 2018/5/23.
//  Copyright © 2018年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterReslut.h"

@interface ImageFilter : NSObject

+ (FilterReslut *)processedOnCPU:(UIImage *)imageToProcess;
+ (FilterReslut *)processedOnCoreImage:(UIImage *)imageToProcess;
+ (FilterReslut *)processedOnGpuImage:(UIImage *)imageToProcess;

@end
