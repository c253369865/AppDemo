//
//  FilterReslut.h
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterReslut : NSObject

@property (nonatomic, assign) CGFloat useTime;
@property (nonatomic, strong) UIImage *resultImage;

+ (instancetype)resultWithTime:(CGFloat)time resultImage:(UIImage *)resultImage;

@end
