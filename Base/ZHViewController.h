//
//  BaseViewController.h
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <Toast/UIView+Toast.h>

@interface ZHViewController : UIViewController

// showLoading,hideLoading 成对使用
- (void)showLoadingWithText:(NSString *)loadingText;
- (void)hideLoading;

- (void)showLoadingWithText:(NSString *)loadingText hideAfterDelay:(NSTimeInterval)delay;

- (void)showMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay;

@end
