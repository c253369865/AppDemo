//
//  ZHMotionViewController.m
//  AppDemo
//
//  Created by TerryChao on 2016/11/2.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHMotionViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ZHMotionViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation ZHMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"加速器,陀螺仪,磁力仪";
    
    NSTimeInterval timeInterval = 0.5;
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager setAccelerometerUpdateInterval:timeInterval];
    [self.motionManager setGyroUpdateInterval:timeInterval];
    [self.motionManager setDeviceMotionUpdateInterval:timeInterval];
    [self.motionManager setMagnetometerUpdateInterval:timeInterval];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAccelermeter:(id)sender {
    if ([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if (accelerometerData) {
                ZHLog(@"accelerometerData -> %@", accelerometerData);
            }
        }];
    }
}

- (IBAction)stopAccelermeter:(id)sender {
    [self.motionManager stopAccelerometerUpdates];
}

- (IBAction)startGyro:(id)sender {
    if ([self.motionManager isGyroAvailable]) {
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (gyroData) {
                ZHLog(@"gyroData -> %@", gyroData);
            }
        }];
    }
}

- (IBAction)stopGyro:(id)sender {
    [self.motionManager stopGyroUpdates];
}


- (IBAction)startDeviceMotion:(id)sender {
    if ([self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (motion) {
                ZHLog(@"motion -> %@", motion);
            }
        }];
    }
}

- (IBAction)stopDeviceMotion:(id)sender {
    [self.motionManager stopDeviceMotionUpdates];
}

- (IBAction)startMagnetometer:(id)sender {
    if ([self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            if (magnetometerData) {
                ZHLog(@"magnetometerData -> %@", magnetometerData);
            }
        }];
    }
}

- (IBAction)stopMagnetometer:(id)sender {
    [self.motionManager stopMagnetometerUpdates];
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
