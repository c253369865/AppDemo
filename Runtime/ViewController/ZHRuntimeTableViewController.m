//
//  ZHRuntimeTableViewController.m
//  AppDemo
//
//  Created by TerryChao on 2017/3/17.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHRuntimeTableViewController.h"
#import "ZHTestRuntime.h"

@interface ZHRuntimeTableViewController ()

@end

@implementation ZHRuntimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Runtime";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
    
    // @[@"字典转模型的自动转换 和 自动归档解档",@"方法交换",@"类别添加属性",@"消息转发",@"Mehtod操作",@"Hook"];
    NSMutableArray *dataList = [NSMutableArray array];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"字典转模型的自动转换 和 自动归档解档" methodName:NSStringFromSelector(@selector(dic2Model))]];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"方法交换" methodName:NSStringFromSelector(@selector(dic2Model))]];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"类别添加属性" methodName:NSStringFromSelector(@selector(dic2Model))]];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"消息转发" methodName:NSStringFromSelector(@selector(dic2Model))]];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"Mehtod操作" methodName:NSStringFromSelector(@selector(dic2Model))]];
    [dataList addObject:[[ZHTestModel alloc] initWithTitle:@"Hook" methodName:NSStringFromSelector(@selector(dic2Model))]];
    self.dataArray = dataList;
}
                                                                                                                  
- (void)dic2Model
{
    [ZHTestRuntime testDic2Model];
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
