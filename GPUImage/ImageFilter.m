//
//  ImageFilter.m
//  AppDemo
//
//  Created by zhihua on 2018/5/23.
//  Copyright © 2018年 czh. All rights reserved.
//

#import "ImageFilter.h"
#import <GPUImage.h>

@implementation ImageFilter

+ (FilterReslut *)processedOnCPU:(UIImage *)imageToProcess {
    CFAbsoluteTime elapsedTime, startTime = CFAbsoluteTimeGetCurrent();
    
    CGImageRef cgImage = [imageToProcess CGImage];
    CGImageRetain(cgImage);
    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
    CFDataRef bitmapData = CGDataProviderCopyData(provider);
    UInt8* data = (UInt8*)CFDataGetBytePtr(bitmapData);
    CGImageRelease(cgImage);
    
    int width = imageToProcess.size.width;
    int height = imageToProcess.size.height;
    NSInteger myDataLength = width * height * 4;
    
    
    for (int i = 0; i < myDataLength; i+=4)
    {
        UInt8 r_pixel = data[i];
        UInt8 g_pixel = data[i+1];
        UInt8 b_pixel = data[i+2];
        
        int outputRed = (r_pixel * .393) + (g_pixel *.769) + (b_pixel * .189);
        int outputGreen = (r_pixel * .349) + (g_pixel *.686) + (b_pixel * .168);
        int outputBlue = (r_pixel * .272) + (g_pixel *.534) + (b_pixel * .131);
        
        if(outputRed>255)outputRed=255;
        if(outputGreen>255)outputGreen=255;
        if(outputBlue>255)outputBlue=255;
        
        
        data[i] = outputRed;
        data[i+1] = outputGreen;
        data[i+2] = outputBlue;
    }
    
    CGDataProviderRef provider2 = CGDataProviderCreateWithData(NULL, data, myDataLength, NULL);
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider2, NULL, NO, renderingIntent);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider2);
    CFRelease(bitmapData);
    
    UIImage *sepiaImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
    CGFloat useTime = elapsedTime * 1000.0;
    FilterReslut *reslut = [FilterReslut resultWithTime:useTime resultImage:sepiaImage];
    return reslut;
}


+ (FilterReslut *)processedOnCoreImage:(UIImage *)imageToProcess {
    
     NSArray *filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
     
     NSLog(@"Built in filters");
     for (NSString *currentFilterName in filterNames)
     {
         NSLog(@"%@", currentFilterName);
     }
    
    CIContext *coreImageContext;
    if (coreImageContext == nil)
    {
        coreImageContext = [CIContext contextWithOptions:nil];
    }
    
    CFAbsoluteTime elapsedTime, startTime = CFAbsoluteTimeGetCurrent();
    
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:imageToProcess.CGImage];
    
//    CIFilter *sepiaTone = [CIFilter filterWithName:@"CIMotionBlur"
//                                     keysAndValues: kCIInputImageKey, inputImage,
//                nil];
    CIFilter *sepiaTone = [CIFilter filterWithName:@"CISepiaTone"
                                     keysAndValues: kCIInputImageKey, inputImage,
                           @"inputIntensity", [NSNumber numberWithFloat:1.0], nil];
    
    CIImage *result = [sepiaTone outputImage];
    
    //    UIImage *resultImage = [UIImage imageWithCIImage:result]; // This gives a nil image, because it doesn't render, unless I'm doing something wrong
    
    CGImageRef resultRef = [coreImageContext createCGImage:result fromRect:CGRectMake(0, 0, imageToProcess.size.width, imageToProcess.size.height)];
    UIImage *resultImage = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
    CGFloat useTime = elapsedTime * 1000.0;
    
    FilterReslut *reslut = [FilterReslut resultWithTime:useTime resultImage:resultImage];
    return reslut;
}

+ (FilterReslut *)processedOnGpuImage:(UIImage *)imageToProcess {
    NSLog(@"begin UIImageOrientation = %ld", imageToProcess.imageOrientation);
    
    CFAbsoluteTime elapsedTime, startTime = CFAbsoluteTimeGetCurrent();

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:imageToProcess];
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];

    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];

    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebufferWithOrientation:imageToProcess.imageOrientation];

    NSLog(@"after UIImageOrientation = %ld", currentFilteredVideoFrame.imageOrientation);
    
    elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
    CGFloat useTime = elapsedTime * 1000.0;
    
//    UIImage *resultImage = [self image:currentFilteredVideoFrame rotation:UIImageOrientationUp];
    FilterReslut *reslut = [FilterReslut resultWithTime:useTime resultImage:currentFilteredVideoFrame];
    return reslut;
}


+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 33 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
