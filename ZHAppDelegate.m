//
//  AppDelegate.m
//  AppDemo
//
//  Created by TerryChao on 16/7/18.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHAppDelegate.h"
#import "ZHTabBarController.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <Toast/UIView+Toast.h>
#import "UMMobClick/MobClick.h"
#import <YYKit.h>
#import "ZHTestRetainStrong.h"

#import "ZHFontBaseTestViewController.h"
#import "ZHWKWebViewTestViewController.h"

//#define TEST_VIEWCONTROLLER [ZHWKWebViewTestViewController new]
#define TEST_VIEWCONTROLLER NO

struct __attribute__((objc_boxable)) StructA
{
    int a;
    float f;
};

@interface ZHAppDelegate ()

@end

@implementation ZHAppDelegate

//应用程序启动后，要执行的委托调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSString *str = (NSString *)[NSNull null];
//    //当调用str.length时，其实是调用NSNull对象的length方法，找不到此方法就会走下面的methodSignatureForSelector方法，来获取length方法签名
//    NSLog(@"%@",str.length);
//    //以下用performSelector调用方法时编译不报错，执行时同上去查找aaaaaa方法,若不实现的话应该找不到方法签名，就会crash掉，这种属于代码编写问题，crash掉才能发现问题~
//    //    [str aaaaaa];
//    [str performSelector:@selector(aaaaaa)];
    
    // log
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDLogDebug(@"%s", __func__);
    ZHLogFunc
    
    ZHLog(@"MainBundle Path:%@", [[NSBundle mainBundle] bundlePath]);
    ZHLog(@"Home Path:%@", NSHomeDirectory());
    
    self.window.tintColor = [UIColor orangeColor]; // !!!--Must set before the rootViewController create--!!!
    if (TEST_VIEWCONTROLLER) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:TEST_VIEWCONTROLLER];
        self.window.rootViewController = nav;
    }
    else {
        self.window.rootViewController = [[ZHTabBarController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    // 这里使用了C99中所引入的结构体复合字面量表达形式以及designated initializer
//    NSValue *value = @((struct StructA){.a = 10, .f = 0.5f});
//
//    struct StructA sa;
//
//    [value getValue:&sa];
//
//    NSLog(@"The value is: %.1f", sa.a + sa.f);
//
////    NSDate *time = YYCompileTime();
////    BOOL ismain = dispatch_is_main_queue();
//    char c = @"沉".charValue;
//    ZHLog(@"------- %c, %@, %@", c, [NSString stringWithUUID], [@" hah d fd " stringByTrim]);
    
    // 开始监听网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            default:
                break;
        }
        ZHLog(@"AFNetworkReachabilityStatus : %ld", status);
        [self.window makeToast:[NSString stringWithFormat:@"network status : %ld", status] duration:1.0 position:CSToastPositionCenter];
    }];
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//    {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }
//    else
//    {
////        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
//    }
    
    
    UMConfigInstance.appKey = @"587dd4109f06fd67f90011a3";
    UMConfigInstance.channelId = @"App Store";
//    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    [MobClick setLogEnabled:YES];
    
//    [ZHTestRetainStrong beginTest];
    
//    int i = 3;
//    do {
//        i++;
//        NSLog(@"i=%d",i);
//    } while (i < 999);
    
    return YES;
}

//应用程序将要由活动状态切换到非活动状态时执行的委托调用，如按下home 按钮，返回主屏幕，或全屏之间切换应用程序等。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    ZHLogFunc
}

//在应用程序已进入后台程序时，要执行的委托调用。所以要设置后台继续运行，则在这个函数里面设置即可。
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    ZHLogFunc
}

//在应用程序将要进入前台时(被激活)，要执行的委托调用，与applicationWillResignActive 方法相对应。
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    ZHLogFunc
}

//在应用程序已被激活后，要执行的委托调用，刚好与  applicationDidEnterBackground 方法相对应。
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    ZHLogFunc
}

//在应用程序要完全退出的时候，要执行的委托调用。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    ZHLogFunc
    [self saveContext];

    // 停止监听网络
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark - NOtifications

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    ZHLog(@"Fail to register for remote notitfications,error:%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertTitle
//
//                                                    message:notification.alertBody
//                          
//                                                   delegate:nil
//                          
//                                          cancelButtonTitle:notification.alertAction
//                          
//                                          otherButtonTitles:nil];
//    
//    [alert show];
    
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    ZHLog(@"notification useinfo %@", notification.userInfo);
//    application.applicationIconBadgeNumber -= 1;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.gz.AppDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - AFNetworkReachabilityManager


@end
