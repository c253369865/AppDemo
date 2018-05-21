//
//  WTImageUpload.h
//  WeToo
//
//  Created by TerryChao on 16/7/7.
//  Copyright © 2016年 LoveOrange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHFileUploadModel : NSObject

@property (strong, nonatomic) NSURL *fileURL;
@property (copy, nonatomic) NSString *uploadKey;
@property (copy, nonatomic) NSString *fileName;
@property (copy, nonatomic) NSString *mimeType;

@end
