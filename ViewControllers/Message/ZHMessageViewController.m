//
//  ZHMessageViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHMessageViewController.h"

@interface ZHMessageViewController ()

@end

@implementation ZHMessageViewController

- (instancetype)init
{
    // 子类重写该方法时不用调用 [super init];
    return [self initWithNibName:NSStringFromClass([ZHMessageViewController class]) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息";
    UIImage *image = [UIImage imageNamed:@"bg"];
    [self.navigationController.navigationBar setShadowImage:nil];
//    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setClipsToBounds:NO];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController.navigationBar setBackIndicatorImage:nil];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:nil];
    self.navigationController.toolbarHidden = NO;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view insertSubview:imageView atIndex:0];
//
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
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
