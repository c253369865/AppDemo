//
//  ZHCameraPreviewView.h
//  AppDemo
//
//  Created by TerryChao on 16/8/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface ZHCameraPreviewView : UIView

@property (assign, nonatomic) AVCaptureSession *session;

- (void)refreshUIInterfaceOrientation;

@end
