//
//  ZHLLLoginModel.h
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHJSONModel.h"

@interface ZHLLLoginModel : ZHJSONModel <NSCoding>

@property (copy, nonatomic) NSString *login_token;
@property (assign, nonatomic) NSInteger login_uid;
@property (copy, nonatomic) NSString *nickname;

@end
