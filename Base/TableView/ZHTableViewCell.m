//
//  ZHTableViewCell.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTableViewCell.h"

@interface ZHTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
