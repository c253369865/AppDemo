//
//  ZHLLEngine.h
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHLLLoginManager.h"

@interface ZHLLEngine : NSObject

@property (strong, nonatomic) ZHLLLoginManager *loginManager;

+ (instancetype)engine;

@end
