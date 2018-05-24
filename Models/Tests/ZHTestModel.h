//
//  ZHTestModel.h
//  AppDemo
//
//  Created by TerryChao on 16/7/20.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "JSONModel.h"

typedef NS_ENUM(NSUInteger, ZHTestModelShowViewStyle) {
    ZHTestModelShowViewStylePush, // default
    ZHTestModelShowViewStylePresent,
    ZHTestModelShowViewStyleDefault = ZHTestModelShowViewStylePush,
};

typedef NS_ENUM(NSUInteger, ZHTestModelCreateType) {
    ZHTestModelCreateTypeNormal,
    ZHTestModelCreateTypeStoryboard,
};

@interface ZHTestModel : JSONModel

@property (copy, nonatomic) NSString *title;
// className,methodString 只能存在一个
// className:需要跳转的ViewController的类名
// methodString:需要执行的方法名
@property (copy, nonatomic) NSString *className;
@property (copy, nonatomic) NSString *methodName;
// 下一个界面弹出方式
@property (assign, nonatomic) ZHTestModelShowViewStyle showViewStyle;
// 默认是 ZHTestModelCreateTypeNormal
@property (assign, nonatomic) ZHTestModelCreateType createType;

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className;
- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className showViewStyle:(ZHTestModelShowViewStyle)showViewStyle;
- (instancetype)initWithTitle:(NSString *)title methodName:(NSString *)methodName;
- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className showViewStyle:(ZHTestModelShowViewStyle)showViewStyle createType:(ZHTestModelCreateType)createType;

@end
