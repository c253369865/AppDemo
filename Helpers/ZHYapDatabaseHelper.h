//
//  ZHYapDatabaseHelper.h
//  AppDemo
//
//  Created by TerryChao on 16/8/4.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHHelper.h"

@class YapDatabase;

typedef NS_ENUM(NSUInteger, ZHStorageType) {
    ZHStorageTypeSync,
    ZHStorageTypeAsync,
};

@interface ZHYapDatabaseHelper : ZHHelper

+ (YapDatabase *)databaseWithFileName:(NSString *)fileName;
+ (void)removeDatabaseFileByName:(NSString *)name;

+ (void)saveObject:(id)value forKey:(NSString *)defaultName;
+ (void)saveObject:(id)object forKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name completionBlock:(dispatch_block_t)completionBlock;

+ (void)loadObjectForKey:(NSString *)key completionBlock:(void (^)(id object))completionBlock;
+ (void)loadObjectForKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name
                    sync:(ZHStorageType)sync completionBlock:(void (^)(id object))completionBlock;

+ (void)removeObjectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name completionBlock:(dispatch_block_t)completionBlock;

@end
