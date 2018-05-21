//
//  ZHTableViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/8/4.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTableViewController.h"
#import <FLKAutoLayout.h>
#import "ZHTestModel.h"
#import "ZHTableViewCell.h"

@interface ZHTableViewController ()

@end

@implementation ZHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //    [self setHidesBottomBarWhenPushed:YES];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        [_tableView alignToView:self.view];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTestModel *model = self.dataArray[indexPath.row];
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZH_TABLEVIEWCELL_ID];
    cell.title = model.title;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHTestModel *model = self.dataArray[indexPath.row];
    
    if (model.methodName) {
        SEL sel = NSSelectorFromString(model.methodName);
        if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:sel];
#pragma clang diagnostic pop
        }
    }
    else if (model.className) {
        ZHViewController *viewController = [[NSClassFromString(model.className) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        
        switch (model.showViewStyle) {
            case ZHTestModelShowViewStylePush:
                [self.navigationController pushViewController:viewController animated:YES];
                break;
            case ZHTestModelShowViewStylePresent:
                [self presentViewController:viewController animated:YES completion:nil];
                break;
        }
    }
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
