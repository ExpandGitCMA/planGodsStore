//
//  ZYDirTool.h
//  JollyChic
//
//  Created by 杨才 on 16/3/9.
//  Copyright © 2016年 Lc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYDirTool : NSObject

+ (NSString *)cachePath;

+ (NSString *)docPath;

+ (NSString *)cachePathWithName:(NSString *)name;

+ (NSString *)docPathWithName:(NSString *)name;

@end
