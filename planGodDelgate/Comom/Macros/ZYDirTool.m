//
//  ZYDirTool.m
//  JollyChic
//
//  Created by 杨才 on 16/3/9.
//  Copyright © 2016年 Lc. All rights reserved.
//

#import "ZYDirTool.h"

//获取主线程
void dispatch_safe_main(dispatch_block_t block) {
    if ([NSThread currentThread].isMainThread) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}


@implementation ZYDirTool

+(NSString *)docPath{
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return cache;
}

+ (NSString *)cachePath{
    NSString *user = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return user;
}

+ (NSString *)cachePathWithName:(NSString *)name{
    return [[self cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",name]];
}

+ (NSString *)docPathWithName:(NSString *)name{
     return [[self docPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",name]];
}


@end
