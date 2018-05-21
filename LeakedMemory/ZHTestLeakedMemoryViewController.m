//
//  ZHTestLeakedMemoryViewController.m
//  AppDemo
//
//  Created by zhihua on 2018/5/15.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "ZHTestLeakedMemoryViewController.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

typedef void(^block)(void);

@interface CLass1 : NSObject

@property (nonatomic, strong) id<UITableViewDelegate> delegate;

- (void)timerRun:(NSTimer *)timer;

@end

@implementation CLass1

- (void)timerRun:(NSTimer *)timer {
    static NSInteger count = 0;
    NSLog(@"timer run... %ld,", count++);
}

@end

@interface ZHTestLeakedMemoryViewController () <UITableViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CLass1 *cls1;
@property (nonatomic, copy) block block1;
@property (nonatomic, copy) NSString *string1;

@end

@implementation ZHTestLeakedMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内存泄漏";
    self.view.backgroundColor = [UIColor grayColor];
    
    /*
     1.NSTimer
     2.delegate
     3.block
     4.非OC对象内存处理
     5.地图类处理
     6.大次数循环内存暴涨问题
     */
    /*
     Instruments-Leaks 真的很没用,上面的内存泄漏,基本检测不出来
     */
//    [self leakMemory1];
//    [self leakMemory2];
//    [self leakMemory3];
//    [self leakMemory4];
    
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"5555 %@", retainCycles);
}

- (void)dealloc {
    [self.timer invalidate];
}

- (void)leakMemory1 {
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.cls1 selector:@selector(timerRun:) userInfo:nil repeats:YES];
    
//    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self.cls1 selector:@selector(timerRun:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)leakMemory2 {
    self.cls1.delegate = self;
}

- (void)leakMemory3 {
    self.block1 = ^(void) {
        self.string1 = @"abc";
    };
}

- (void)leakMemory4 {
    for (int i = 1; i < 999; i++) {
        UIImage *image = [UIImage imageNamed:@"bg"];
        CIImage *beginImage = [[CIImage alloc] initWithImage:image];
    }
}

- (CLass1 *)cls1 {
    if (!_cls1) {
        _cls1 = [CLass1 new];
    }
    return _cls1;
}

- (void)timerRun:(NSTimer *)timer {
    [UIView animateWithDuration:1 animations:^{
        CGFloat r = (CGFloat)arc4random_uniform(256) / 255.0;
        CGFloat g = (CGFloat)arc4random_uniform(256) / 255.0;
        CGFloat b = (CGFloat)arc4random_uniform(256) / 255.0;
        self.view.backgroundColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1];
        static NSInteger count = 0;
        NSLog(@"timer run... %ld,r=%.0f,g=%.0f,b=%.0f,thread=%@", count++,r,g,b, [NSThread currentThread]);
    }];
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
