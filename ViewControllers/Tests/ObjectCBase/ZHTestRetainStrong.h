//
//  ZHTestRetainStrong.h
//  AppDemo
//
//  Created by TerryChao on 2017/3/15.
//  Copyright © 2017年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTestRetainStrong : NSObject

@property (retain, nonatomic) NSString *retainStr;
@property (strong, nonatomic) NSString *strongStr;
@property (copy, nonatomic) NSString *copStr;

+ (void)beginTest;

@end
