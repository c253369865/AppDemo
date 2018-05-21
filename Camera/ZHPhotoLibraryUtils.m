//
//  ZHPhotoLibraryUtils.m
//  AppDemo
//
//  Created by TerryChao on 16/8/22.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHPhotoLibraryUtils.h"
#import <Photos/Photos.h>

@implementation ZHPhotoLibraryUtils

+ (BOOL)savePhotoToLivrary:(NSData *)imageData
{
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            // To preserve the metadata, we create an asset from the JPEG NSData representation.
            // Note that creating an asset from a UIImage discards the metadata.
            // In iOS 9, we can use -[PHAssetCreationRequest addResourceWithType:data:options].
            // In iOS 8, we save the image to a temporary file and use +[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:].
            if ( [PHAssetCreationRequest class] ) {
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                } completionHandler:^( BOOL success, NSError *error ) {
                    if ( ! success ) {
                        NSLog( @"Error occurred while saving image to photo library: %@", error );
                    }
                }];
            }
            else {
                NSString *temporaryFileName = [NSProcessInfo processInfo].globallyUniqueString;
                NSString *temporaryFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[temporaryFileName stringByAppendingPathExtension:@"jpg"]];
                NSURL *temporaryFileURL = [NSURL fileURLWithPath:temporaryFilePath];
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    NSError *error = nil;
                    [imageData writeToURL:temporaryFileURL options:NSDataWritingAtomic error:&error];
                    if ( error ) {
                        NSLog( @"Error occured while writing image data to a temporary file: %@", error );
                    }
                    else {
                        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:temporaryFileURL];
                    }
                } completionHandler:^( BOOL success, NSError *error ) {
                    if ( ! success ) {
                        NSLog( @"Error occurred while saving image to photo library: %@", error );
                    }
                    
                    // Delete the temporary file.
                    [[NSFileManager defaultManager] removeItemAtURL:temporaryFileURL error:nil];
                }];
            }
        }
    }];

    return YES;
}

+ (void)saveVideoToLibrary:(NSURL *)outputFileURL completionHandler:(void (^)(void))completionHandler
{    
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            // Save the movie file to the photo library and cleanup.
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // In iOS 9 and later, it's possible to move the file into the photo library without duplicating the file data.
                // This avoids using double the disk space during save, which can make a difference on devices with limited free disk space.
                if ( [PHAssetResourceCreationOptions class] ) {
                    PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
                    options.shouldMoveFile = YES;
                    PHAssetCreationRequest *changeRequest = [PHAssetCreationRequest creationRequestForAsset];
                    [changeRequest addResourceWithType:PHAssetResourceTypeVideo fileURL:outputFileURL options:options];
                }
                else {
                    [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputFileURL];
                }
            } completionHandler:^( BOOL success, NSError *error ) {
                if ( ! success ) {
                    NSLog( @"Could not save movie to photo library: %@", error );
                }
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }
        else {
            if (completionHandler) {
                completionHandler();
            }
        }
    }];
}


@end
