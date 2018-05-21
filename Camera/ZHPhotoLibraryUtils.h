//
//  ZHPhotoLibraryUtils.h
//  AppDemo
//
//  Created by TerryChao on 16/8/22.
//  Copyright © 2016年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHPhotoLibraryUtils : NSObject

+ (BOOL)savePhotoToLivrary:(NSData *)imageData;
+ (void)saveVideoToLibrary:(NSURL *)outputFileURL completionHandler:(void (^)(void))completionHandler;

@end
