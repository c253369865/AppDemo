//
//  ZHLLLoginModel.m
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLLoginModel.h"

@implementation ZHLLLoginModel

+ (BOOL)propertyIsIgnored:(NSString *)propertyName
{
    return [propertyName isEqualToString:@"nickname"];
}

@end
