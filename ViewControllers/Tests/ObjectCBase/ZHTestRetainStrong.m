//
//  ZHTestRetainStrong.m
//  AppDemo
//
//  Created by TerryChao on 2017/3/15.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHTestRetainStrong.h"

@implementation ZHTestRetainStrong


+ (void)beginTest
{
    ZHTestRetainStrong *test = [ZHTestRetainStrong new];
    [test test];
}

- (void)test
{
    NSMutableString *newStr = [NSMutableString stringWithFormat:@"abcd"];
    self.retainStr = newStr;
    self.strongStr = newStr;
    self.copStr = newStr;
    
    NSLog(@"newStr sting:%@", newStr);
    NSLog(@"retain sting:%@", self.retainStr);
    NSLog(@"strong string:%@", self.strongStr);
    NSLog(@"copy string:%@", self.copStr);
    NSLog(@"------------");
    
    [newStr appendString:@"123"];
//    [newStr appendString:@"-456"];
    
    NSLog(@"newStr sting:%@", newStr);
    NSLog(@"retain sting:%@", self.retainStr);
    NSLog(@"strong string:%@", self.strongStr);
    NSLog(@"copy string:%@", self.copStr);
    NSLog(@"------------");
    
    newStr = nil;
    
    NSLog(@"newStr sting:%@", newStr);
    NSLog(@"retain sting:%@", self.retainStr);
    NSLog(@"strong string:%@", self.strongStr);
    NSLog(@"copy string:%@", self.copStr);
    NSLog(@"------------");
    
    [newStr appendString:@"+++"];
    
    NSLog(@"newStr sting:%@", newStr);
    NSLog(@"retain sting:%@", self.retainStr);
    NSLog(@"strong string:%@", self.strongStr);
    NSLog(@"copy string:%@", self.copStr);
}

@end
