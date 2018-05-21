//
//  ZHMacros.h
//  AppDemo
//
//  Created by TerryChao on 16/7/18.
//  Copyright © 2016年 czh. All rights reserved.
//

#ifndef ZHMacros_h
#define ZHMacros_h

//-------------------日志-------------------------
#import <CocoaLumberjack/CocoaLumberjack.h>
static const DDLogLevel ddLogLevel = DDLogLevelAll;

// 方法输出
//#define ZHLogFunc NSLog(@"%s", __func__);
//#define ZHLog(...) NSLog(__VA_ARGS__);
#define ZHLogFunc DDLogDebug(@"%s", __func__);
#define ZHLog(...) DDLogDebug(__VA_ARGS__);

#if DEBUG
#define EveryplayLog(fmt, ...) NSLog((@"[#%.3d] %s " fmt), __LINE__, __PRETTY_FUNCTION__,##__VA_ARGS__)
#else
#define EveryplayLog(...)
#endif

// EveryplayALog always displays output regardless of the DEBUG setting
#ifndef EveryplayALog
#define EveryplayALog(fmt, ...)   NSLog((@"[#%.3d] %s " fmt), __LINE__, __PRETTY_FUNCTION__,##__VA_ARGS__)
#endif

#define ELOG EveryplayLog(@"")

//-------------------日志-------------------------

#define ZH_TABLEVIEWCELL_ID @"ZH_TABLEVIEWCELL_ID"
#define ZH_TOAST_DURATION 1.5

// LoveLive
#define ZH_LL_IS_LOGIN [[ZHLLEngine engine].loginManager isLogin]



//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_H 44
//获取屏幕 宽度、高度
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)

//-------------------获取设备大小-------------------------





#endif /* ZHMacros_h */
