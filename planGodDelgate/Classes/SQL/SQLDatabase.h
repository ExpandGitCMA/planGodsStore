//
//  SQLDatabase.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/25.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface SQLDatabase : NSObject

// 线程安全
@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;
/**
 单例,直接使用,内部会帮助创建本地数据库
 
 @return 单例
 */
+ (SQLDatabase *)sharedInstance;

/**
 返回本地数据库路径
 
 @return 数据库路径
 */
+ (NSString *)dbPath;
@end
