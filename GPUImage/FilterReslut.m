//
//  FilterReslut.m
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "FilterReslut.h"

@implementation FilterReslut

+ (instancetype)resultWithTime:(CGFloat)time resultImage:(UIImage *)resultImage {
    FilterReslut *reslut = [FilterReslut new];
    reslut.useTime = time;
    reslut.resultImage = resultImage;
    return reslut;
}

@end
