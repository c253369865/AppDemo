//
//  ZHTestunion.h
//  AppDemo
//
//  Created by TerryChao on 2017/3/15.
//  Copyright © 2017年 czh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef union
{
    int a;
    NSInteger b;
    BOOL c;
    char *d;
    NSString *e;
}Testunion;

struct
{
    int a;
    NSString *s;
}TestStruct;

@interface ZHTestunion : NSObject

@end


@protocol Protocol1 <NSObject>

- (void)method1;
- (void)method2;

@end

@protocol Protocol2 <NSObject>

- (void)method1;
- (void)method2;

@end

@interface ClassA : NSObject <Protocol1, Protocol2>

@end
