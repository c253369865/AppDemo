//
//  ZHTestRuntime.h
//  AppDemo
//
//  Created by TerryChao on 2017/3/17.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHBaseTest.h"

@interface ZHTestRuntime : ZHBaseTest

// @[@"字典转模型的自动转换 和 自动归档解档",@"方法交换",@"类别添加属性",@"消息转发",@"Mehtod操作",@"Hook"];
+ (void)testDic2Model;
- (void)testSwitchMethod;
- (void)testCategoriesAddProperty;
- (void)testMessageRelay;
- (void)testMethodOperation;
- (void)testHook;

@end
