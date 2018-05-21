//
//  ZHLLModel.m
//  AppDemo
//
//  Created by TerryChao on 16/7/25.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLModel.h"

@implementation ZHLLModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return [propertyName isEqualToString:@"content"];
}

- (instancetype)initWithError:(NSError *)error
{
    self = [super init];
    if (self) {
        self.code = [error code];
        self.msg = [error localizedDescription];
    }
    return self;
}

@end
