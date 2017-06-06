//
//  SQLDatabase.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/25.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "SQLDatabase.h"

@interface SQLDatabase ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

@implementation SQLDatabase
static SQLDatabase *_dbHelp = nil;

#pragma mark - 单例
+ (SQLDatabase *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_dbHelp==nil) {
            _dbHelp = [[super allocWithZone:NULL] init];
        }
    });
    return _dbHelp;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
     NSLog(@"第二次掉用");
    return [SQLDatabase sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone{
      NSLog(@"第三次掉用");
    return [[SQLDatabase allocWithZone:zone] init];
}


#pragma mark - other
- (FMDatabaseQueue *)dbQueue {
    if (_dbQueue == nil) {
        // 第一次使用时创建db
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[[self class] dbPath]];
    }
    
    return _dbQueue;
}

+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName {
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // 创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    docsDir = [docsDir stringByAppendingPathComponent:directoryName];
    BOOL isExist;
    BOOL isDir;
    isExist = [fileManager fileExistsAtPath:docsDir isDirectory:&isDir];
    if (!isExist || !isDir) {
        [fileManager createDirectoryAtPath:docsDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [docsDir stringByAppendingPathComponent:@"DB.sqlite"];
}

+ (NSString *)dbPath {
    return [[self class] dbPathWithDirectoryName:@"FMDB"];
}

@end
