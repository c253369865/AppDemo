//
//  ZHCameraPreviewView.m
//  AppDemo
//
//  Created by TerryChao on 16/8/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHCameraPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZHCameraPreviewView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    return previewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    previewLayer.session = session;
}


- (void)refreshUIInterfaceOrientation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Why are we dispatching this to the main queue?
        // Because AVCaptureVideoPreviewLayer is the backing layer for AAPLPreviewView and UIView
        // can only be manipulated on the main thread.
        // Note: As an exception to the above rule, it is not necessary to serialize video orientation changes
        // on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
        
        // Use the status bar orientation as the initial video orientation. Subsequent orientation changes are handled by
        // -[viewWillTransitionToSize:withTransitionCoordinator:].
        UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
        AVCaptureVideoOrientation initialVideoOrientation = AVCaptureVideoOrientationPortrait;
        if ( statusBarOrientation != UIInterfaceOrientationUnknown ) {
            initialVideoOrientation = (AVCaptureVideoOrientation)statusBarOrientation;
        }
        
        AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
        previewLayer.connection.videoOrientation = initialVideoOrientation;
    } );
}

@end
