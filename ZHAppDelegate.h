//
//  AppDelegate.h
//  AppDemo
//
//  Created by TerryChao on 16/7/18.
//  Copyright © 2016年 czh. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef void(^haha)(void);

@interface ZHAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, assign) haha haha1;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

