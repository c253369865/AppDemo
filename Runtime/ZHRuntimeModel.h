//
//  ZHRuntimeModel.h
//  AppDemo
//
//  Created by TerryChao on 2017/3/17.
//  Copyright © 2017年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHRuntimeModel : NSObject <NSCoding>

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDic:(NSDictionary *)dic;

- (void)dic2Model:(NSDictionary *)dic;
- (NSDictionary *)model2Dic;

@end
