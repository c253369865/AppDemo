//
//  GZTabBarController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/18.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHNavigationController.h"
#import "ZHHomeViewController.h"
#import "ZHSearchViewController.h"
#import "ZHMessageViewController.h"
#import "ZHUserInfoViewController.h"

typedef NS_ENUM(NSUInteger, ZHTabBarItemTag) {
    ZHTabBarItemTagHome = 1,
    ZHTabBarItemTagSearch,
    ZHTabBarItemTagMessage,
    ZHTabBarItemTagUserInfo,
};

@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    {
        ZHHomeViewController *viewController = [ZHHomeViewController new];
//        viewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
//        viewController.tabBarItem.title = @"主页"; // no work
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"UIKit" image:[UIImage imageNamed:@"live2_v2"] tag:ZHTabBarItemTagHome];
        viewController.tabBarItem.badgeValue = @"1";
        ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:viewController];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
    
    {
        ZHSearchViewController *viewController = [ZHSearchViewController new];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ThreeP" image:[UIImage imageNamed:@"one2_v2"] tag:ZHTabBarItemTagSearch];
        viewController.tabBarItem.badgeValue = @"0";
        ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
    
    {
        ZHMessageViewController *viewController = [ZHMessageViewController new];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"news2_v2"] tag:ZHTabBarItemTagMessage];
        viewController.tabBarItem.badgeValue = @"AAAA";
        ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
    
    {
        ZHUserInfoViewController *viewController = [ZHUserInfoViewController new];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"center2_v2"] tag:ZHTabBarItemTagUserInfo];
        viewController.tabBarItem.badgeValue = @"✨";
        ZHNavigationController *nav = [[ZHNavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }

    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor orangeColor];
    
//    [self setSelectedIndex:2];
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
