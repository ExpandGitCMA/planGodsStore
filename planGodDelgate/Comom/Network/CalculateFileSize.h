//
//  CalculateFileSize.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/1.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateFileSize : NSObject
//类方法

+ (instancetype)defaultCalculateFileSize;

// 计算文件大小
- (float)fileSizeAtPath:(NSString*)path;

// 清除文件按
- (void)clearCache:(NSString *)path;

@end
