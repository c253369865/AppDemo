//
//  BaseNavigationController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHNavigationController.h"
#import "ZHImageUtil.h"

@interface ZHNavigationController ()

@end

@implementation ZHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationBar setBackgroundImage:[ZHImageUtil imageWithSize:CGSizeMake(1, 64.0) color:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage imageNamed:@"navibar_shadow"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
