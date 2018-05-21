//
//  ZHUserInfoViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//
#import "ZHUserInfoViewController.h"
#import "YYImage.h"

@interface ZHUserInfoViewController ()

@property (weak, nonatomic) IBOutlet YYImage *view1;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *view2;

@end

@implementation ZHUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人";
    
    _view1 = [YYImage imageNamed:@"001@2x.gif"];
    _view2.image = [YYImage imageNamed:@"001"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer *doubleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    doubleGestureRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleGestureRecognizer];
    
    UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [self.view addGestureRecognizer:longGestureRecognizer];
}

- (void)onTap:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"cmd=%@, gestureRecognizer=%@", NSStringFromSelector(_cmd), gestureRecognizer);
}

- (void)onDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"cmd=%@, gestureRecognizer=%@", NSStringFromSelector(_cmd), gestureRecognizer);
}

- (void)onLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"cmd=%@, gestureRecognizer=%@", NSStringFromSelector(_cmd), gestureRecognizer);
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
