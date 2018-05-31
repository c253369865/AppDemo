//
//  ZHGPUImageTarbarTableViewController.m
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "ZHGPUImageTarbarTableViewController.h"

@interface ZHGPUImageTarbarTableViewController () <UITabBarControllerDelegate>

@end

@implementation ZHGPUImageTarbarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPUImage";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger tag = item.tag;
    switch (tag) {
        case 0:
            self.title = @"Still Images";
        default:
            self.title = @"Video";
    }
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
