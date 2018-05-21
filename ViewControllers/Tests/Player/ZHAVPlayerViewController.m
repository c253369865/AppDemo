//
//  ZHAVPlayerViewController.m
//  AppDemo
//
//  Created by TerryChao on 16/7/19.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHAVPlayerViewController.h"
#import "ZHAVPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <FLKAutoLayout/FLKAutoLayout.h>
#import "ZHAVPlayerControlCollectionViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ZHAVPlayerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UICollectionView *controlCollectionView;

@property (strong, nonatomic) NSArray *collectionData;
@property (strong, nonatomic) ZHAVPlayerView *playerView;

@end

@implementation ZHAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"AVPlayer";
    [self addPlayer];
    
    [self.controlCollectionView registerNib:[UINib nibWithNibName:@"ZHAVPlayerControlCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ZH_TABLEVIEWCELL_ID];
    self.collectionData = @[@(ZHPlayerControlTypePlay), @(ZHPlayerControlTypePause), @(ZHPlayerControlTypeResume), @(ZHPlayerControlTypeStop)];
    
    // 主动内存泄漏
    // 1. Timer
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(commentAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
    
- (void)commentAnimation {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    ZHLog(@"viewDidAppear mainScreen %@", NSStringFromCGRect([[UIScreen mainScreen] bounds]));
    ZHLog(@"viewDidAppear view %@", NSStringFromCGRect(self.view.bounds));
}

- (void)addPlayer
{
    ZHLog(@"mainScreen %@", NSStringFromCGRect([[UIScreen mainScreen] bounds]));
    ZHLog(@"view %@", NSStringFromCGRect(self.view.bounds));
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"start.mp4"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];
    self.playerView = [[ZHAVPlayerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.playerView playWithItem:playerItem];
    [self.playerView setVolume:0.1];
    [self.playerView setBackgroundColor:[UIColor clearColor]];
    [self.videoView addSubview:self.playerView];
    [self.playerView alignToView:self.videoView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHPlayerControlType controlType = [self.collectionData[indexPath.row] unsignedIntegerValue];
    ZHAVPlayerControlCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZH_TABLEVIEWCELL_ID forIndexPath:indexPath];
    cell.controlType = controlType;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHPlayerControlType controlType = [self.collectionData[indexPath.row] unsignedIntegerValue];
    AVPlayer *player = self.playerView.player;
    switch (controlType) {
        case ZHPlayerControlTypePlay:
        {
            [player seekToTime:kCMTimeZero];
            [player play];
        }
            break;
        case ZHPlayerControlTypePause:
        {
            [player pause];
        }
            break;
        case ZHPlayerControlTypeResume:
        {
            [player play];
        }
            break;
        case ZHPlayerControlTypeStop:
            break;
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
