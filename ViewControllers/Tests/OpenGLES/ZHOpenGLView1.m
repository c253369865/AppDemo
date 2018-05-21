//
//  ZHOpenGLView1.m
//  AppDemo
//
//  Created by TerryChao on 2017/1/7.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHOpenGLView1.h"

@implementation ZHOpenGLView1

+ (Class)layerClass
{
    // 只有 [CAEAGLLayer class] 类型的 layer 才支持在其上描绘 OpenGL 内容。
    return [CAEAGLLayer class];
}

@end
