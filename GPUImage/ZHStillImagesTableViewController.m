//
//  ZHStillImagesTableViewController.m
//  AppDemo
//
//  Created by zhihua on 2018/5/31.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "ZHStillImagesTableViewController.h"
#import "ImageFilter.h"
#import "FilterReslut.h"

@interface ZHStillImagesTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ZHStillImagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterType filterType = indexPath.row;
    UIImage *originImage = [UIImage imageNamed:@"Lambeau"];
    UIImage *resultImage;
    switch (filterType) {
        case FilterTypeCpu:
        {
            FilterReslut *filterResult = [ImageFilter processedOnCPU:originImage];
            self.cpuProcessingTime = filterResult.useTime;
        }
            break;
        case FilterTypeCoreImage:
        {
            FilterReslut *filterResult = [ImageFilter processedOnCoreImage:originImage];
            resultImage = filterResult.resultImage;
            self.coreImageProcessingTime = filterResult.useTime;
        }
            break;
        case FilterTypeGPUImage:
        {
            FilterReslut *filterResult = [ImageFilter processedOnGpuImage:originImage];
            resultImage = filterResult.resultImage;
            self.gpuProcessingTime = filterResult.useTime;
        }
            break;
        default:
            break;
    }
    if (resultImage) {
        self.bgImageView.image = resultImage;
    } else {
        self.bgImageView.image = originImage;
    }
    
    [tableView reloadData];
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
