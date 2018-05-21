//
//  ZHTestYapdatabaseViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/8/4.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestYapdatabaseViewController.h"
#import "ZHTestMD5ViewController.h"

@interface ZHTestYapdatabaseViewController ()

@end

@implementation ZHTestYapdatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"YapDatabase";
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"open database" methodName:NSStringFromSelector(@selector(openYapDatabase))]];
    [array addObject:[[ZHTestModel alloc] initWithTitle:@"save simple model" methodName:NSStringFromSelector(@selector(saveSimpleModel))]];
    
    self.dataArray = array;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openYapDatabase
{
//    [self showMessage:@"openYapDatabase" hideAfterDelay:ZH_TOAST_DURATION];
    YapDatabase * yap = [ZHYapDatabaseHelper databaseWithFileName:nil];
    ZHLog(@"yapDatabase:%@", yap);
}

- (void)saveSimpleModel
{
    ZHLLLoginModel *loginModel = [[ZHLLLoginModel alloc] init];
    loginModel.login_uid = 15300;
    loginModel.login_token = @"2546df365c5f4a4aa86c6155f6518672";
    [ZHYapDatabaseHelper saveObject:loginModel forKey:@"testSimpleModel"];
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
