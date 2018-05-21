//
//  ZHLLEngine.m
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLEngine.h"

@implementation ZHLLEngine

+ (instancetype)engine
{
    static ZHLLEngine *engine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [ZHLLEngine new];
    });
    return engine;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginManager = [ZHLLLoginManager sharedManager];
    }
    return self;
}

@end
