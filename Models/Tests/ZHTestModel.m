//
//  ZHTestModel.m
//  AppDemo
//
//  Created by TerryChao on 16/7/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHTestModel.h"

@implementation ZHTestModel

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className
{
    self = [super init];
    if (self) {
        self.title = title;
        self.className = className;
        self.showViewStyle = ZHTestModelShowViewStyleDefault;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className showViewStyle:(ZHTestModelShowViewStyle)showViewStyle
{
    self = [super init];
    if (self) {
        self.title = title;
        self.className = className;
        self.showViewStyle = showViewStyle;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title methodName:(NSString *)methodName
{
    self = [super init];
    if (self) {
        self.title = title;
        self.methodName = methodName;
    }
    return self;
}

@end
