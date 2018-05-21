//
//  ZHTestSplitViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/8/26.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestSplitViewController.h"
#import "ZHTestSplitDetailViewController.h"

@interface ZHTestSplitViewController () <UISplitViewControllerDelegate>

@end

@implementation ZHTestSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"SplitViewController";
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    return UISplitViewControllerDisplayModeAllVisible;
}

- (IBAction)buttonTouchUpInside:(id)sender {
    ZHTestSplitViewController *viewController = [[ZHTestSplitViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
