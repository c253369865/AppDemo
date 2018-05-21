//
//  ZHJSONModel.m
//  AppDemo
//
//  Created by TerryChao on 16/7/26.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHJSONModel.h"

@implementation ZHJSONModel

+ (instancetype)newWithJson:(id)json
{
    if (![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSError* err = nil;
    id model = [[self alloc] initWithDictionary:json error:&err];
    if (err) {
        ZHLog(@"Coverting json:%@ \nto model error:%@", json, err.description);
    }
    return model;

}

@end
