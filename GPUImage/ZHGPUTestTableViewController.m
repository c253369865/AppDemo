//
//  ZHGPUTestTableViewController.m
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "ZHGPUTestTableViewController.h"

@interface ZHGPUTestTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZHGPUTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    FilterType filterType = indexPath.row;
    switch (filterType) {
        case FilterTypeCpu:
            cell.textLabel.text = @"Cpu";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms", _cpuProcessingTime];
            break;
        case FilterTypeCoreImage:
            cell.textLabel.text = @"CoreImage";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms", _coreImageProcessingTime];
            break;
        case FilterTypeGPUImage:
            cell.textLabel.text = @"GPUImage";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0fms", _gpuProcessingTime];
            break;
        default:
            break;
    }
    
    return cell;
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
