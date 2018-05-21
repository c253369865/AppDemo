//
//  ZHLLUserModel.h
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHJSONModel.h"

@interface ZHLLUserModel : ZHJSONModel

@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger user_grade;
@property (assign, nonatomic) NSInteger user_type;
@property (assign, nonatomic) NSInteger verify_status;
@property (assign, nonatomic) NSInteger vip_status;

@end
