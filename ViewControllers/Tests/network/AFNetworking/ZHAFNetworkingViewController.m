//
//  ZHAFNetworkingViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/22.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHAFNetworkingViewController.h"
#import "ZHAVPlayerViewController.h"
#import "ZHLayoutVisualFormatViewController.h"
#import "ZHTestModel.h"
#import <AFNetworking.h>
#import <Toast/UIView+Toast.h>
#import "ZHLLApiManager.h"
#import "ZHLLEngine.h"

//#define url @"http://api.loveorange.com/live-api/base/version/ios"

@interface ZHAFNetworkingViewController ()

@end

@implementation ZHAFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"AFNetworking";
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"网络状态" methodName:NSStringFromSelector(@selector(showNetworkingStatus))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"获取验证码" methodName:NSStringFromSelector(@selector(accountSignupCode))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"登陆" methodName:NSStringFromSelector(@selector(signup))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"获取个人信息" methodName:NSStringFromSelector(@selector(loadUserInfo))]];
    
    self.dataArray = array;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNetworkingStatus
{
    NSString *tipsText;
    AFNetworkReachabilityStatus networkStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    switch (networkStatus) {
        case AFNetworkReachabilityStatusUnknown:
            tipsText = @"未知的网络";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            tipsText = @"当前网络不可用";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            tipsText = @"使用运营商网络";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            tipsText = @"使用Wifi网络";
            break;
    }
    
    [self.view makeToast:tipsText duration:ZH_TOAST_DURATION position:CSToastPositionCenter];
}

- (void)accountSignupCode
{
    [[ZHLLApiManager sharedManager] accountSignupCode:@"18515634862" nationCode:@"86" handle:^(ZHLLModel *model) {
//        NSInteger i = 2;
    }];
}

- (void)signup
{
    [[ZHLLApiManager sharedManager] v2AccountLoginSubmit:@"18515634862" nationCode:@"86" authCode:@"100000" requestType:0 showStatus:YES cacheTime:100 handle:nil];
}

- (void)loadUserInfo
{
//    [[ZHLLApiManager sharedManager] accountInfoGetBasic:@"15300" requestType:ZHRequestTypePOST showStatus:YES cacheTime:0 handle:^(ZHLLApiCode code, NSString *error, ZHLLUserModel *model) {
//        [[ZHLLEngine engine].loginManager setCurrentUser:model saved:YES];
//    }];
//    [ZHLLEngine engine].loginManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
