//
//  ZHAVPlayerControlCollectionViewCell.m
//  AppDemo
//
//  Created by TerryChao on 16/7/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHAVPlayerControlCollectionViewCell.h"

@interface ZHAVPlayerControlCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *controllImageView;
@property (weak, nonatomic) IBOutlet UILabel *controlTitleLabel;

@end

@implementation ZHAVPlayerControlCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setControlType:ZHPlayerControlTypePlay];
}

- (void)setControlType:(ZHPlayerControlType)controlType
{
    _controlType = controlType;
    
    UIImage *controlImage;
    NSString *controlTitleText;
    
    switch (_controlType) {
        case ZHPlayerControlTypePlay:
            controlImage = [UIImage imageNamed:@"video_play"];
            controlTitleText = @"播放";
            break;
        case ZHPlayerControlTypePause:
            controlImage = [UIImage imageNamed:@"video_pasue"];
            controlTitleText = @"暂停";
            break;
        case ZHPlayerControlTypeResume:
            controlImage = [UIImage imageNamed:@"video_resume"];
            controlTitleText = @"继续";
            break;
        case ZHPlayerControlTypeStop:
            controlImage = [UIImage imageNamed:@"video_stop"];
            controlTitleText = @"停止";
            break;
    }
    
    self.controllImageView.image = controlImage;
    self.controlTitleLabel.text = controlTitleText;
}

@end
