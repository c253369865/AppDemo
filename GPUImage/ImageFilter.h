//
//  ImageFilter.h
//  AppDemo
//
//  Created by zhihua on 2018/5/23.
//  Copyright © 2018年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterReslut : NSObject

@property (nonatomic, assign) CGFloat useTime;
@property (nonatomic, strong) UIImage *resultImage;

+ (instancetype)resultWithTime:(CGFloat)time resultImage:(UIImage *)resultImage;

@end

@implementation FilterReslut

+ (instancetype)resultWithTime:(CGFloat)time resultImage:(UIImage *)resultImage {
    FilterReslut *reslut = [FilterReslut new];
    reslut.useTime = time;
    reslut.resultImage = resultImage;
    return reslut;
}

@end


@interface ImageFilter : NSObject

+ (FilterReslut *)processedOnCPU:(UIImage *)imageToProcess;
+ (FilterReslut *)processedOnCoreImage:(UIImage *)imageToProcess;
+ (FilterReslut *)processedOnGpuImage:(UIImage *)imageToProcess;

@end
