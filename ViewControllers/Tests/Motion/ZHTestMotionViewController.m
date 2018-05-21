//
//  ZHTestMotionViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/8/16.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestMotionViewController.h"
#import "ZHTestMotionGraphTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define TABLEVIEW_CELL @"ZHTestMotionGraphTableViewCell"

@interface ZHTestMotionViewController ()

@end

@implementation ZHTestMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"加速器";
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"A" methodName:NSStringFromSelector(@selector(didReceiveMemoryWarning))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"B" methodName:NSStringFromSelector(@selector(didReceiveMemoryWarning))]];
    
    self.dataArray = array;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTestMotionGraphTableViewCell" bundle:nil] forCellReuseIdentifier:TABLEVIEW_CELL];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZHTestModel *model = self.dataList[indexPath.row];
    ZHTestMotionGraphTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL];
//    cell.backgroundColor = [UIColor greenColor];
//    cell.title = model.title;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50.0)];
    header.backgroundColor = [UIColor darkTextColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, header.frame.size.width, 50.0)];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%lu", section];
    [header addSubview:label];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [tableView fd_heightForCellWithIdentifier:TABLEVIEW_CELL cacheByKey:TABLEVIEW_CELL configuration:nil];
    return 112.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ZHTestModel *model = self.dataList[indexPath.row];
//    
//    if (model.methodName) {
//        SEL sel = NSSelectorFromString(model.methodName);
//        if ([self respondsToSelector:sel]) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [self performSelector:sel];
//#pragma clang diagnostic pop
//        }
//    }
//    else if (model.className) {
//        ZHViewController *viewController = [[NSClassFromString(model.className) alloc] init];
//        viewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
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
