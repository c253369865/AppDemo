//
//  ZHAVPlayerControlCollectionViewCell.h
//  AppDemo
//
//  Created by TerryChao on 16/7/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZHPlayerControlType) {
    ZHPlayerControlTypePlay = 0,
    ZHPlayerControlTypePause,
    ZHPlayerControlTypeResume,
    ZHPlayerControlTypeStop,
};


@interface ZHAVPlayerControlCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) ZHPlayerControlType controlType;

@end
