//
//  ZHLLModel.h
//  AppDemo
//
//  Created by TerryChao on 16/7/25.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHJSONModel.h"

typedef NS_ENUM(NSInteger, ZHLLApiCode) {
    ZHLLApiCodeSuccess = 0,
    ZHLLApiCodeFail,
};

@interface ZHLLModel : ZHJSONModel

@property (copy, nonatomic) NSString *msg;
@property (assign, nonatomic) ZHLLApiCode code;
// #warning TODO:有时不是 NSDictionary
@property (strong, nonatomic) NSDictionary *content;

- (instancetype)initWithError:(NSError *)error;

@end
