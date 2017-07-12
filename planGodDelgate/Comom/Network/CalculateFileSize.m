//
//  CalculateFileSize.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/1.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "CalculateFileSize.h"
#import "PlanConst.h"
#include <sys/types.h>
#include<sys/stat.h>

static CalculateFileSize *caCheFile = nil;
@interface CalculateFileSize ()

@end

@implementation CalculateFileSize
+ (id)allocWithZone:(NSZone *)zone{
    return [self defaultCalculateFileSize];
}

+(instancetype)defaultCalculateFileSize{
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch , ^{
        if (caCheFile==nil) {
            //保证唯一实例化对象
            caCheFile = [[super allocWithZone:NULL] init];
        }
    });
    return caCheFile;
}


-(float)fileSizeAtPath:(NSString *)path{
    
    //获取当前图片缓存路径
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager=[NSFileManager  defaultManager];
    
    //定义变量存储总的缓存大小
     long long size = 0;
    //获取当前缓存路径下的所有子路径
    NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
        //遍历所有子文件
    for (NSString *subPath in subPaths) {
         //1）.拼接完整路径
         NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
        //2）.计算文件的大小
        long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil]fileSize];
        //3）.加载到文件的大小
         size += fileSize;
        }
    
    return size/(1024*1024);
}

// 循环调用fileSizeAtPath来获取一个目录所占空间大小
+ (long long) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}
//使用c语言获取目录下的缓存大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    DEBUG_NSLog(@"cacheFilePath==%@",cacheFilePath);
     [fileManager removeItemAtPath:cacheFilePath error:nil];
}


@end
