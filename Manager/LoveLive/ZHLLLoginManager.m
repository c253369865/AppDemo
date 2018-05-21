//
//  ZHLLLoginManager.m
//  AppDemo
//
//  Created by TerryChao on 16/7/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLLoginManager.h"

#import <YapDatabase/YapDatabase.h>
#import <objc/runtime.h>

@interface ZHLLLoginManager ()

@end

@implementation ZHLLLoginManager

#pragma mark - 继承方法

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self saveLoginInfo];
        [self loadLoginInfo];
    }
    return self;
}

- (BOOL)saveLoginInfo
{
//    _loginInfo = [[ZHLLLoginModel alloc] init];
//    _loginInfo.login_uid = 15300;
//    _loginInfo.login_token = @"2546df365c5f4a4aa86c6155f6518672";

    NSDate *start = [NSDate date];
    
    [ZHYapDatabaseHelper saveObject:self.loginInfo forKey:@"loginInfo"];
    
    NSTimeInterval elapsed = [start timeIntervalSinceNow] * -1.0;
    NSLog(@"save login info database: total time: %.6f", elapsed);

    return YES;
}

- (void)loadLoginInfo
{
    NSDate *start = [NSDate date];
    
    [ZHYapDatabaseHelper loadObjectForKey:@"loginInfo" completionBlock:^(id object) {
        self.loginInfo = object;
    }];
    
    NSTimeInterval elapsed = [start timeIntervalSinceNow] * -1.0;
    NSLog(@"load login info database: total time: %.6f", elapsed);
}

#pragma mark - 公共方法

- (void)setLoginInfo:(ZHLLLoginModel *)loginInfo saved:(BOOL)saved
{
    _loginInfo = loginInfo;
    if (saved) {
        [self saveLoginInfo];
    }
}

- (BOOL)isLogin
{
    return _loginInfo.login_uid != 0;
}

- (void)setCurrentUser:(ZHLLUserModel *)currentUser saved:(BOOL)saved
{
    _currentUser = currentUser;
    if (saved) {
    }
}

@end
