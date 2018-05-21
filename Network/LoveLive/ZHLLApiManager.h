//
//  ZHAFNetworkManager.h
//  AppDemo
//
//  Created by ; on 16/7/25.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLModel.h"

typedef NS_ENUM(NSUInteger, ZHRequestType) {
    ZHRequestTypePOST = 0, // 默认为POST
    ZHRequestTypeGET = 1,
};

@interface ZHLLApiManager : NSObject

// 网络请求方式 GET, POST等,默认是 ZHRequestTypePOST
@property (assign, nonatomic) ZHRequestType requestType;
// 是否展示请求状态,默认是展示YES
@property (assign, nonatomic) BOOL showStatus;
// 缓存时间:缓存有效时长,单位为秒,0表示不用缓存,nil-表示使用默认缓存时长
@property (assign, nonatomic) NSInteger cacheTime;

+ (instancetype)sharedManager;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

#pragma mark - 业务请求

// 获取登陆验证码
- (NSURLSessionTask *)accountSignupCode:(NSString *)phone nationCode:(NSString *)nationCode handle:(void (^)(ZHLLModel *model))handle;

// 登陆
- (NSURLSessionTask *)v2AccountLoginSubmit:(NSString *)phone nationCode:(NSString *)nationCode
                                  authCode:(NSString *)authCode requestType:(ZHRequestType)requestType
                                showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLLoginModel *model))handle;

// 获取用户基本资料
- (NSURLSessionTask *)accountInfoGetBasic:(NSString *)targetUid requestType:(ZHRequestType)requestType
                               showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime
                                   handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLUserModel *model))handle;

// 修改个人资料
- (NSURLSessionTask *)accountInfoModify:(NSString *)targetUid requestType:(ZHRequestType)requestType
                             showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime
                                 handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLUserModel *model))handle;

@end
