//
//  ZHTestPhotoLibraryViewController.m
//  AppDemo
//
//  Created by TerryChao on 2016/12/27.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestPhotoLibraryViewController.h"
#import "ZHPhotoCollectionViewCell.h"

@interface ZHTestPhotoLibraryViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (assign, nonatomic) NSInteger lines;
@property (strong, nonatomic) NSMutableArray *datas;
@property (assign, nonatomic) CGFloat cellWidth;
@end

@implementation ZHTestPhotoLibraryViewController

static NSString * const cellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"照片";
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"ZHPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    self.lines = 4;
    self.datas = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 100; i++) {
        [self.datas addObject:[NSNumber numberWithInteger:i]];
    }
    self.cellWidth = (SCREEN_W - ((self.lines-1)*1)) / self.lines;
//    self.cellWidth = SCREEN_W / self.lines;
    ZHLog(@"cellWidth = %.f SCREEN_W=%.f", self.cellWidth, SCREEN_W);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHLog(@"collectionView, indexPath=%@", indexPath);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *number = self.datas[indexPath.row];
    ZHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld", [number integerValue]];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 指定每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.cellWidth, self.cellWidth);
//    CGFloat inset  = collectionView.bounds.size.width * (6/64.0f);
//    return CGSizeMake(collectionView.bounds.size.width - (2 *inset), collectionView.bounds.size.height * 3/4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    CGFloat inset  = collectionView.bounds.size.width * (6/64.0f);
//    inset = floor(inset);
//    return UIEdgeInsetsMake(0,inset, 0,inset);
//    NSInteger edge = 10;
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

@end
