//
//  ZHDisplayLinkViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/9/6.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHDisplayLinkViewController.h"
#import <QuartzCore/CADisplayLink.h>

@interface ZHDisplayLinkViewController ()

@property (strong, nonatomic) CADisplayLink *dLink;

@end

@implementation ZHDisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =  @"DisplayLink";
    
    self.dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(dLink:)];
    [self.dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.dLink.frameInterval = 60.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dLink:(id)sender
{
    [UIView beginAnimations:@"dLink" context:nil];
    
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    self.view.backgroundColor = color;
    
    [UIView commitAnimations];
}

- (IBAction)startClick:(id)sender {
    [self.dLink setPaused:NO];
}

- (IBAction)stopClick:(id)sender {
    [self.dLink setPaused:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected obje
 ct to the new view controller.
}
*/

@end
