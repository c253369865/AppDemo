//
//  ZHTestOpenGLESViewController.m
//  AppDemo
//
//  Created by TerryChao on 2017/1/7.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHTestOpenGLESViewController.h"
#import <GLKit/GLKit.h>
#import "ZHTestOpenGL1ViewController.h"
#import "ZHTestModel.h"

@interface ZHTestOpenGLESViewController ()

@property (nonatomic, strong) CALayer *currentLayer;

@end

@implementation ZHTestOpenGLESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"OpenGLES";
//    [self setCurrentLayer:[self getCAEAGLLayer1]];
    // 设置清屏颜色
//    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
    // 用来指定要用清屏颜色来清除由mask指定的buffer，此处是color buffer
//    glClear(GL_COLOR_BUFFER_BIT);
    
//    [self.tableView setBackgroundColor:[UIColor blackColor]];
    
    NSMutableArray *dataList = [NSMutableArray array];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"OpenGL1" className:@"ZHTestOpenGL1ViewController"]];
    self.dataArray = dataList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CALayer *)getCAEAGLLayer1 {
    CAEAGLLayer *eaglLayer = [CAEAGLLayer layer];
    eaglLayer.frame = self.view.frame;
    eaglLayer.opaque = YES; //CALayer默认是透明的
    
    // 描绘属性：这里不维持渲染内容
    // kEAGLDrawablePropertyRetainedBacking:若为YES，则使用glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)计算得到的最终结果颜色的透明度会考虑目标颜色的透明度值。
    // 若为NO，则不考虑目标颜色的透明度值，将其当做1来处理。
    // 使用场景：目标颜色为非透明，源颜色有透明度，若设为YES，则使用glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)得到的结果颜色会有一定的透明度（与实际不符）。若未NO则不会（符合实际）。
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
    
    return eaglLayer;
}

- (void)setCurrentLayer:(CALayer *)currentLayer
{
    self.currentLayer = currentLayer;
    [self.tableView.layer addSublayer:currentLayer];
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
