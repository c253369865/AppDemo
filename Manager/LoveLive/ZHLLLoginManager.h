//
//  ZHLLLoginManager.h
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHManager.h"

@class ZHLLLoginModel, ZHLLUserModel;

@interface ZHLLLoginManager : ZHManager

@property (strong, nonatomic) ZHLLLoginModel *loginInfo;
@property (strong, nonatomic) ZHLLUserModel *currentUser;

- (void)setLoginInfo:(ZHLLLoginModel *)loginInfo saved:(BOOL)saved;
- (BOOL)isLogin;

- (void)setCurrentUser:(ZHLLUserModel *)currentUser saved:(BOOL)saved;


@end
