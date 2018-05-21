//
//  ZHTableViewController.h
//  AppDemo
//
//  Created by TerryChao on 16/8/4.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHViewController.h"

@interface ZHTableViewController : ZHViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end
