//
//  ZHVideoFilter.h
//  AppDemo
//
//  Created by zhihua on 2018/5/28.
//  Copyright © 2018年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ZHVideoFilter : NSObject

+ (void)processedOnCPU:(CVPixelBufferRef *)bufferToProcess;

@end
