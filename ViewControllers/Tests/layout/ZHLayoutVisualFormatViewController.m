//
//  ZHLayoutVisualFormatViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/21.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHLayoutVisualFormatViewController.h"

@interface ZHLayoutVisualFormatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation ZHLayoutVisualFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"constraintsWithVisualFormat";
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    ZHLogFunc
    // 放在此处没作用
//    [self addConstraints];
}

- (void)addConstraints
{
    [self.view removeConstraints:self.view.constraints];
    
    UILabel *firstName = self.firstNameLabel;
    UILabel *lastName = self.lastNameLabel;
    UIImageView *imageView = self.imageView;
    UITextView *detail = self.detailTextView;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(firstName,lastName,imageView,detail);

    NSDictionary *metrics = @{@"width":@160.0, @"horizontalSpacing":@15.0, @"verticalSpacing":@10};

    NSArray<NSLayoutConstraint *> *constraints = [NSLayoutConstraint constraintsWithVisualFormat:
                                                  @"H:|-[imageView(100)]-horizontalSpacing-[firstName(>=width)]-|"
//                                                                                         options:0 // 设成0,导致靠上属性不成功
                                                                                         options:NSLayoutFormatAlignAllTop
                                                                                         metrics:metrics
                                                                                           views:views];
    
    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat:
                    @"H:[imageView]-horizontalSpacing-[lastName(>=width)]-|"
                                                           options:0
                                                           metrics:metrics
                                                             views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat:
                    @"H:[imageView]-horizontalSpacing-[detail(>=width)]-|"
//                                                           options:0 // 设成0，导致TextView看不到内容，没有高度，NSLayoutFormatAlignAllBottom意为底部对齐
                                                           options:NSLayoutFormatAlignAllBottom
                                                           metrics:metrics
                                                             views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint constraintsWithVisualFormat:
                    @"V:|-30-[firstName]-verticalSpacing-[lastName]-verticalSpacing-[detail]"
                                                           options:0
                                                           metrics:metrics
                                                             views:views]];

    // 打开注释看差别
//    constraints = [constraints arrayByAddingObjectsFromArray:
//                   [NSLayoutConstraint constraintsWithVisualFormat:
//                    @"V:|-50-[imageView]"
//                                                           options:0
//                                                           metrics:metrics
//                                                             views:views]];
    
    [self.view addConstraints:constraints];
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
