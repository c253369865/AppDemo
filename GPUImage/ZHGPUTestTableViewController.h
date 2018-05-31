//
//  ZHGPUTestTableViewController.h
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FilterType) {
    FilterTypeCpu,
    FilterTypeCoreImage,
    FilterTypeGPUImage,
};

@interface ZHGPUTestTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) CGFloat cpuProcessingTime;
@property (assign, nonatomic) CGFloat coreImageProcessingTime;
@property (assign, nonatomic) CGFloat gpuProcessingTime;

@end
