//
//  ZHCamera.h
//  AppDemo
//
//  Created by TerryChao on 16/8/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


typedef NS_ENUM(NSInteger, AVCamSetupResult) {
    AVCamSetupResultSuccess,
    AVCamSetupResultCameraNotAuthorized,
    AVCamSetupResultSessionConfigurationFailed
};

@protocol ZHCameraDelegate <AVCaptureFileOutputRecordingDelegate>

@end

@interface ZHCamera : NSObject

@property (strong, nonatomic) AVCaptureSession *session;
@property (assign, nonatomic) id<ZHCameraDelegate> delegate;
@property (strong, nonatomic) dispatch_queue_t sessionQueue;
@property (strong, nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOutput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (assign, nonatomic) AVCamSetupResult setupResult;
@property (assign, nonatomic) BOOL saveToLibrary;
@property (weak, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

- (instancetype)initWithDelegate:(id<ZHCameraDelegate>)delegate previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer;
- (void)startRunning;
- (void)stopRunning;
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange;
- (BOOL)sessionRunning;
- (void)toggleMovieRecording;
- (void)swtichCamera:(void (^)(void))completionHandler;
- (void)snapStillImage:(void (^)(UIImage *image))completionHandler;

@end
