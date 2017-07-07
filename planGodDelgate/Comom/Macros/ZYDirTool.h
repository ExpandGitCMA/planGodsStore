//
//  ZYDirTool.h
//  JollyChic
//
//  Created by 杨才 on 16/3/9.
//  Copyright © 2016年 Lc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void dispatch_safe_main(dispatch_block_t block);

@interface ZYDirTool : NSObject

+ (NSString *)cachePath;

+ (NSString *)docPath;

+ (NSString *)cachePathWithName:(NSString *)name;

+ (NSString *)docPathWithName:(NSString *)name;

@end
