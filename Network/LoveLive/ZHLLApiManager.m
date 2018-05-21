//
//  ZHAFNetworkManager.m
//  AppDemo
//
//  Created by TerryChao on 16/7/25.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLLApiManager.h"
#import <AFNetworking.h>
#import "ZHLLApiConfig.h"
#import "ZHLLModel.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "ZHLLEngine.h"

#define ZH_HTTP_CACHE_TIME 60*60

@interface ZHLLApiManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation ZHLLApiManager

+ (instancetype)sharedManager
{
    static ZHLLApiManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZHLLApiManager alloc] initWithBaseUrl:ll_api_base_url];
    });
    return manager;
}

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
{
    self = [self init];
    if (self) {
        self.requestType = ZHRequestTypePOST;
        self.showStatus = YES;
        self.cacheTime = ZH_HTTP_CACHE_TIME;
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        //  #warning TODO:这个用手机的当前语言,具体格式与服务器商定
        [self.sessionManager.requestSerializer setValue:@"zh_cn" forHTTPHeaderField:@"Accept-Language"];
    }
    return self;
}

#pragma mark -
/*
 Lovelive的网络签名写的很乱,后端也没有对签名做验证;只用参数生成签名
 应该是:
 1. 为所有请求添加公用参数,如blbx_ct,platform,version,appkey
 2. 用参数生成签名sign
 3. 需要处理请求头部语言问题,在session初始化时添加了
 */

- (NSMutableDictionary *)generateCommonParamters:(BOOL)containLoginInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *currentTime = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    [parameters setObject:currentTime forKey:@"blbx_ct"];
    [parameters setObject:@"1" forKey:@"platform"];
    [parameters setObject:@"3.2.2" forKey:@"version"];
    [parameters setObject:ll_app_key forKey:@"appkey"];
    if (containLoginInfo && ZH_LL_IS_LOGIN) {
        ZHLLLoginModel *model = [ZHLLEngine engine].loginManager.loginInfo;
        [parameters setObject:[[NSNumber numberWithInteger:model.login_uid] stringValue] forKey:@"login_uid"];
        [parameters setObject:model.login_token forKey:@"login_token"];
    }
    return parameters;
}

- (NSString *)generateSign:(NSDictionary *)parameters
{
    NSMutableString *sign = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    NSMutableString *signString;
    NSArray *sortedKeys = [[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in sortedKeys) {
        [signString appendFormat:@"%@%@", key, [parameters objectForKey:key]];
    }
    [signString appendString:ll_app_secret];
    
    // SHA1
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([stringBytes bytes], (CC_LONG)[stringBytes length], digest)) {
        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            unsigned char aChar = digest[i];
            [sign appendFormat:@"%02X", aChar];
        }
    }
    
    return sign;
}

#pragma mark - 基础请求函数
// 请求的头部在session初始化时已定,这里没得改变
// 请求的头部具体是什么,是跟服务器商定的
- (NSURLSessionTask *)GET:(NSString *)apiPath
                   parameters:(id)parameters
                   showStatus:(BOOL)showStatus
                    cacheTime:(NSInteger)cacheTime
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(ZHLLModel *model))success
                      failure:(void (^)(ZHLLModel *model))failure
{
    if (showStatus) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    NSURLSessionDataTask *task = [self.sessionManager GET:apiPath parameters:parameters progress:downloadProgress
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            ZHLLModel *model = [ZHLLModel newWithJson:responseObject];
            ZHLog(@"GET success api:%@ \n %@", apiPath, model);
            if (success) {
                success(model);
            }
            if (showStatus) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ZHLLModel *model = [[ZHLLModel alloc] initWithError:error];
            ZHLog(@"GET failure api:%@ \n %@", apiPath, model);
            if (failure) {
                failure(model);
            }
            if (showStatus) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
        }];
    [task resume];
    return task;
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)apiPath
                             parameters:(nullable id)parameters
                             showStatus:(BOOL)showStatus
                              cacheTime:(NSInteger)cacheTime
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(void (^)(ZHLLModel *model))success
                                failure:(void (^)(ZHLLModel *model))failure
{
    if (showStatus) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    NSURLSessionDataTask *task = [self.sessionManager POST:apiPath
                                                parameters:parameters
                                 constructingBodyWithBlock:block
                                                  progress:uploadProgress
                                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        ZHLLModel *model = [ZHLLModel newWithJson:responseObject];
                                                        ZHLog(@"POST success api:%@ \n %@", apiPath, model);
                                                        if (success) {
                                                            success(model);
                                                        }
                                                        if (showStatus) {
                                                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                        }
                                                   }
                                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                         ZHLLModel *model = [[ZHLLModel alloc] initWithError:error];
                                                         ZHLog(@"POST failure api:%@ \n %@", apiPath, model);
                                                         if (failure) {
                                                             failure(model);
                                                         }
                                                         if (showStatus) {
                                                             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                         }
                                                   }];
    return task;

}

- (NSURLSessionTask *)request:(NSString *)apiPath
                   parameters:(nullable id)parameters
                  requestType:(ZHRequestType)requestType
                   showStatus:(BOOL)showStatus
                    cacheTime:(NSInteger)cacheTime
    constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                      success:(void (^)(ZHLLModel *llmodel))success
                      failure:(void (^)(ZHLLModel *llmodel))failure
{
    ZHLog(@"------------ request start ------------");
    ZHLog(@"api:%@",apiPath);
    ZHLog(@"parameters:\n%@",parameters);
    
    switch (requestType) {
        case ZHRequestTypePOST:
            return [self POST:apiPath parameters:parameters showStatus:showStatus cacheTime:cacheTime constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
        case ZHRequestTypeGET:
            return [self GET:apiPath parameters:parameters showStatus:showStatus cacheTime:cacheTime progress:nil success:success failure:failure];
    }
}

#pragma mark - 业务请求
// 获取登陆验证码
- (NSURLSessionTask *)accountSignupCode:(NSString *)phone nationCode:(NSString *)nationCode handle:(void (^)(ZHLLModel *model))handle
{
    static NSString *apiPath = @"v2/account/login/sendLoginAuthCode";

    NSMutableDictionary *parameters = [self generateCommonParamters:NO];
    [parameters setObject:phone forKey:@"phone"];
    [parameters setObject:nationCode forKey:@"nation_code"];
    NSString *sign = [self generateSign:parameters];
    [parameters setObject:sign forKey:@"sign"];

    return [self request:apiPath parameters:parameters requestType:ZHRequestTypeGET showStatus:self.showStatus cacheTime:self.showStatus constructingBodyWithBlock:nil progress:nil success:handle failure:handle];
}

// 登陆
- (NSURLSessionTask *)v2AccountLoginSubmit:(NSString *)phone nationCode:(NSString *)nationCode
                                  authCode:(NSString *)authCode requestType:(ZHRequestType)requestType
                                showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLLoginModel *model))handle
{
    static NSString *apiPath = @"v2/account/login/submit";

//    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *adId = @"DA79897D-5577-4AF0-25AF-92D84F0E32F9";
    
    NSMutableDictionary *parameters = [self generateCommonParamters:NO];
    [parameters setObject:phone forKey:@"phone"];
    [parameters setObject:nationCode forKey:@"nation_code"];
    [parameters setObject:authCode forKey:@"auth_code"];
    [parameters setObject:adId forKey:@"device_id"];
    NSString *sign = [self generateSign:parameters];
    [parameters setObject:sign forKey:@"sign"];
    
    return [self request:apiPath parameters:parameters requestType:ZHRequestTypePOST
              showStatus:showStatus cacheTime:cacheTime constructingBodyWithBlock:nil progress:nil
            success:^(ZHLLModel *llmodel) {
                ZHLLLoginModel *model;
                if (llmodel.code == ZHLLApiCodeSuccess) {
                    model = [ZHLLLoginModel newWithJson:llmodel.content];
                }
                [[ZHLLEngine engine].loginManager setLoginInfo:model saved:YES];
            } failure:^(ZHLLModel *llmodel) {
                [[ZHLLEngine engine].loginManager setLoginInfo:nil saved:YES];
            }];
}

// 获取用户基本资料
- (NSURLSessionTask *)accountInfoGetBasic:(NSString *)targetUid requestType:(ZHRequestType)requestType
                               showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime
                                   handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLUserModel *model))handle
{
    static NSString *apiPath = @"account/info/getBasic";
    
    NSMutableDictionary *parameters = [self generateCommonParamters:YES];
    [parameters setObject:targetUid forKey:@"target_uid"];
    NSString *sign = [self generateSign:parameters];
    [parameters setObject:sign forKey:@"sign"];
    
    return [self request:apiPath parameters:parameters requestType:ZHRequestTypePOST
              showStatus:showStatus cacheTime:cacheTime constructingBodyWithBlock:nil progress:nil
                 success:^(ZHLLModel *llmodel) {
                     ZHLLUserModel *model;
                     if (llmodel.code == ZHLLApiCodeSuccess) {
                         model = [ZHLLUserModel newWithJson:llmodel.content];
                     }
                     handle(llmodel.code, llmodel.msg, model);
                 } failure:^(ZHLLModel *llmodel) {
                     handle(llmodel.code, llmodel.msg, nil);
                 }];
}


// 修改个人资料
- (NSURLSessionTask *)accountInfoModify:(NSString *)targetUid requestType:(ZHRequestType)requestType
                               showStatus:(BOOL)showStatus cacheTime:(NSInteger)cacheTime
                                   handle:(void (^)(ZHLLApiCode code, NSString *error, ZHLLUserModel *model))handle
{
    static NSString *apiPath = @"account/info/modify";

    UIImage *image = [UIImage imageNamed:@"cat"];
    UIImage *image1 = [UIImage imageNamed:@"cat"];
    
    NSMutableArray *files = [NSMutableArray array];

    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fileCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/WTImages/"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileCacheDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:fileCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *cacheimagePath = [fileCacheDir stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] createFileAtPath:cacheimagePath contents:imageData attributes:nil];
        
        ZHFileUploadModel *imageInfo = [ZHFileUploadModel new];
        imageInfo.fileURL = [NSURL fileURLWithPath:cacheimagePath];
        imageInfo.fileName = fileName;
        imageInfo.mimeType = @"image/jpg";
        imageInfo.uploadKey = @"img";
        
        [files addObject:imageInfo];
    }
    
    {
        NSData *imageData = UIImageJPEGRepresentation(image1, 0.5);
        NSString *fileCacheDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/WTImages/"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileCacheDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:fileCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@_s.jpg", str];
        NSString *cacheimagePath = [fileCacheDir stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] createFileAtPath:cacheimagePath contents:imageData attributes:nil];
        
        ZHFileUploadModel *imageInfo = [ZHFileUploadModel new];
        imageInfo.fileURL = [NSURL fileURLWithPath:cacheimagePath];
        imageInfo.fileName = fileName;
        imageInfo.mimeType = @"image/jpg";
        imageInfo.uploadKey = @"img";
        
        [files addObject:imageInfo];
    }
    
    NSMutableDictionary *parameters = [self generateCommonParamters:YES];
    [parameters setObject:((ZHFileUploadModel *)files[0]).fileName forKey:@"avatar"];
    NSString *sign = [self generateSign:parameters];
    [parameters setObject:sign forKey:@"sign"];
    
    return [self request:apiPath parameters:parameters requestType:ZHRequestTypePOST showStatus:YES cacheTime:cacheTime
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (ZHFileUploadModel *imageInfo in files) {
                [formData appendPartWithFileURL:imageInfo.fileURL name:imageInfo.uploadKey fileName:imageInfo.fileName mimeType:imageInfo.mimeType error:nil];
            }
        } progress:^(NSProgress *uploadProgress) {
//            int c = 3;
        } success:^(ZHLLModel *llmodel) {
            ZHLLUserModel *model;
            if (llmodel.code == ZHLLApiCodeSuccess) {
                model = [ZHLLUserModel newWithJson:llmodel.content];
            }
            handle(llmodel.code, llmodel.msg, model);
        } failure:^(ZHLLModel *llmodel) {
//            int c = 3;
        }
    ];
}

@end
