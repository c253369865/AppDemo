//
//  BaseViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHViewController.h"
#import <MBProgressHUD.h>
#import <Toast/UIView+Toast.h>
#import "ZHMacros.h"

@interface ZHViewController ()

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation ZHViewController
//
//+ (id)alloc
//{
//    id obj = [super alloc];
////    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
//    return obj;
//}

- (void)dealloc
{
    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 界面自动放在 navigationBar 下面, 默认状态，子类需要就自己做调整
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    ZHLog(@"%@: %@", NSStringFromSelector(_cmd), self);
}

#pragma mark - loading

/*
 这东西 每次 hub 都是从父类移除的,所以每次展示都是要新加,不是很好
 mode:
 MBProgressHUDModeDeterminate:转圈进度条
 MBProgressHUDModeText:单文本
 MBProgressHUDModeIndeterminate:loading+文本
 */
- (MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        _hud = [[MBProgressHUD alloc] initWithView:self.view]; // 下面两种还要自己添加到 self.view
//        _hud = [MBProgressHUD HUDForView:self.view]; // 下面两种还要自己添加到 self.view
        _hud.mode = MBProgressHUDModeText;
        _hud.label.text = @"Loading...";
    }
    return _hud;
}

- (void)hideLastHub
{
    if (self.hud) {
        [self.hud hideAnimated:NO];
        self.hud = nil;
    }
}

- (void)showLoadingWithText:(NSString *)loadingText
{
    [self hideLastHub];
    
    self.hud.label.text = loadingText;
    [self.hud.label setText:loadingText];
    [self.hud setMode:MBProgressHUDModeIndeterminate];
    [self.hud showAnimated:YES];
}

- (void)hideLoading
{
    [self hideLastHub];
}

- (void)showLoadingWithText:(NSString *)loadingText hideAfterDelay:(NSTimeInterval)delay
{
    [self showLoadingWithText:loadingText];
    [self.hud hideAnimated:YES afterDelay:delay];
}

// toast 可以操作, hub 不可操作
- (void)showMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay
{
//    [self hideLastHub];
//    [self.hud.label setText:message];
//    [self.hud setMode:MBProgressHUDModeText];
//    [self.hud showAnimated:YES];
//    [self.hud hideAnimated:YES afterDelay:delay];
    
    [self.view makeToast:message duration:delay position:CSToastPositionCenter];
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




