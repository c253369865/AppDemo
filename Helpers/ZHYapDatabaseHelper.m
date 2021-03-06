//
//  ZHYapDatabaseHelper.m
//  AppDemo
//
//  Created by TerryChao on 16/8/4.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHYapDatabaseHelper.h"
#import <YapDatabase.h>
#import <MD5Digest/NSString+MD5.h>

#define ZH_STORAGE_CIPHET_PREFIX @"c(75*!4e0@.;FfXC"

@implementation ZHYapDatabaseHelper

#pragma mark - 私有方法

+ (NSString *)databaseName:(NSString *)fileName
{
    if (fileName.length < 1) {
        fileName = @"ZHDB";
    }
    return [NSString stringWithFormat:@"ZHDB_%@.sqlite", fileName];
}

+ (NSString *)databasePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    
    return [baseDir stringByAppendingPathComponent:[self databaseName:fileName]];
}

#pragma mark - 公开方法

+ (YapDatabase *)databaseWithFileName:(NSString *)fileName
{
    NSString *databasePath = [self databasePath:fileName];
    
    YapDatabaseOptions *options = [[YapDatabaseOptions alloc] init];
//    options.pragmaSynchronous = YapDatabasePragmaSynchronous_Normal;
    options.pragmaMMapSize = (1024 * 1024 * 25); // full file size, with max of 25 MB
    options.cipherKeyBlock = ^ NSData *(void){
        // Note: The return type is NSData, and does NOT have to be a string in UTF-8.
        // It can be any kind of blob of data, including randomly generated bytes.
        //            NSString *md5String;
        //            if (fileName) {
        //                md5String = [[NSString stringWithFormat:@"%@%@", ZH_STORAGE_CIPHET_PREFIX, fileName] MD5Digest];
        //            }
        //            else {
        //                md5String = [[NSString stringWithFormat:@"%@%@", ZH_STORAGE_CIPHET_PREFIX, @"TWDB"] MD5Digest];
        //            }
        //            ZHLog(@"md5String:%@", md5String);
        //            ZHLog(@"md5String NSData:%@", [md5String dataUsingEncoding:NSUTF8StringEncoding]);
        //            return [md5String dataUsingEncoding:NSUTF8StringEncoding];
        
        return [@"123" dataUsingEncoding:NSUTF8StringEncoding];
    };
    
    YapDatabase *database = [[YapDatabase alloc] initWithPath:databasePath
                                                   serializer:NULL
                                                 deserializer:NULL
                                                      options:options];
    
    ZHLog(@"fileName:%@", fileName);
    ZHLog(@"database:%@", database);
    return database;
}

+ (void)removeDatabaseFileByName:(NSString *)name
{
    NSString *databasePath = [self databasePath:name];
    // Delete old database file (if exists)
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:databasePath error:&error];
    if (error) {
        ZHLog(@"removeItemAtPath error:%@",error);
    }
}

+ (void)saveObject:(id)value forKey:(NSString *)defaultName
{
    [self saveObject:value forKey:defaultName inCollection:nil databaseName:nil completionBlock:nil];
}

+ (void)saveObject:(id)object forKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name completionBlock:(dispatch_block_t)completionBlock
{
    __block YapDatabase *database = [self databaseWithFileName:name];
    __block YapDatabaseConnection *connection = [database newConnection];
    
    [connection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction setObject:object forKey:key inCollection:collection];
    } completionBlock:^{
        database = nil;
        connection = nil;
        if (completionBlock) {
            completionBlock();
        }
    }];
}

+ (void)loadObjectForKey:(NSString *)key completionBlock:(void (^)(id))completionBlock
{
    [self loadObjectForKey:key inCollection:nil databaseName:nil sync:ZHStorageTypeSync completionBlock:completionBlock];
}

+ (void)loadObjectForKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name sync:(ZHStorageType)sync completionBlock:(void (^)(id object))completionBlock
{
    __block YapDatabase *database = [self databaseWithFileName:name];
    __block YapDatabaseConnection *connection = [database newConnection];
    
    if (sync == ZHStorageTypeSync) {
        [connection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
            id data = [transaction objectForKey:key inCollection:collection];
            if (completionBlock) {
                completionBlock(data);
            }
        }];
        database = nil;
        connection = nil;
    }
    else {
        [connection asyncReadWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
            id data = [transaction objectForKey:key inCollection:collection];
            if (completionBlock) {
                completionBlock(data);
            }
        } completionBlock:^{
            database = nil;
            connection = nil;
        }];
    }
}

+ (void)removeObjectForKey:(NSString *)key
{
    [self removeObjectForKey:key inCollection:nil databaseName:nil completionBlock:nil];
}

+ (void)removeObjectForKey:(NSString *)key inCollection:(NSString *)collection databaseName:(NSString *)name completionBlock:(dispatch_block_t)completionBlock
{
    __block YapDatabase *database = [self databaseWithFileName:name];
    __block YapDatabaseConnection *connection = [database newConnection];
    
    [connection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction removeObjectForKey:key inCollection:collection];
    } completionBlock:^{
        database = nil;
        connection = nil;
        if (completionBlock) {
            completionBlock();
        }
    }];
}


@end
