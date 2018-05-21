//
//  ZHManager.m
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHManager.h"

@implementation ZHManager

+ (NSMutableDictionary *)subClasses
{
    static NSMutableDictionary *subClasses = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        subClasses = [NSMutableDictionary dictionary];
    });
    return subClasses;
}

+ (instancetype)sharedManager
{
    NSString *className = NSStringFromClass([self class]);
    id manager = [self subClasses][className];
    if (!manager) {
        manager = [self new];
        [self subClasses][className] = manager;
        ZHLog(@"%@ is created.", className);
    }
    return manager;
}

// 想要在父类实现所有的单例,上面才是正确的做法
//+ (instancetype)sharedManager
//{
//    static id manager;
//    if (!manager) {
//        manager = [[[self class] alloc] init];
//    }
//    return manager;
//}

@end
