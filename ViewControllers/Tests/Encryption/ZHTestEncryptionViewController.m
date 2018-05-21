//
//  ZHTestEncryptionViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/28.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestEncryptionViewController.h"
#import "ZHTestMD5ViewController.h"

@interface ZHTestEncryptionViewController ()

@end

@implementation ZHTestEncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"加密";
    
    NSMutableArray *array = [NSMutableArray array];
    {
        ZHTestModel *model = [[ZHTestModel alloc] initWithTitle:@"MD5" className:NSStringFromClass([ZHTestMD5ViewController class])];
        [array addObject:model];
    }
    
    self.dataArray = array;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZHTableViewCell" bundle:nil] forCellReuseIdentifier:ZH_TABLEVIEWCELL_ID];
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
