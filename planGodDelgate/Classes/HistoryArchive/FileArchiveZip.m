//
//  FileArchiveZip.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "FileArchiveZip.h"
#import "PlanColorDef.h"
#import "SSZipArchive.h"
@interface FileArchiveZip ()<SSZipArchiveDelegate>

@end

@implementation FileArchiveZip
-(NSString*)pathscacheFolder{
    //获取指定沙盒目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *cacheFolder = [docPath stringByAppendingPathComponent:IMAGECACHE_FOLDERNAME_CACHE];
    return cacheFolder;
}


//- (NSArray*)paths{
//    NSString *path = [self pathscacheFolder];
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSMutableArray*arraySource = [[NSMutableArray alloc]init];
//    NSDirectoryEnumerator *enumerator;
//    enumerator = [fileManager enumeratorAtPath:path];
//    while((path = [enumerator nextObject]) != nil) {
//        if (![path isEqualToString:@".DS_Store"]) {
//             NSString*url = [NSString stringWithFormat:@"%@%@%@",[self pathscacheFolder],@"/",path];
//            [arraySource addObject:url];
//        }
//    }
//    return [arraySource copy];
//}

-(void)initWithPath{

    // 获得mainBundle中所有的png的图片路径
    NSArray *pngs = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:nil];
        
    // zip文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *zipFilepath = [caches stringByAppendingPathComponent:@"pngs.zip"];
    
    // 创建zip文件
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:zipFilepath withFilesAtPaths:pngs];
    
    if (isSuccess) {
        NSLog(@"write success");
    } else {
        NSLog(@"write fail");
    }

    
    
    
}

-(void)archiveZip{

    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [caches stringByAppendingPathComponent:@"pngs.zip"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 解压(文件大, 会比较耗时，所以放到子线程中解压)
         BOOL isSuccess =   [SSZipArchive unzipFileAtPath:filepath toDestination:[self pathscacheFolder]delegate:self];
        // 可以指定解压地址
  
        if (isSuccess) {
            NSLog(@"write success");
            
        } else {
            NSLog(@"write fail");
        }
    });
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath{
    
    
    
    DEBUG_NSLog(@"unzippedPath=%@",unzippedPath);
    NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:unzippedPath error:nil];
    NSString *zipUrl;
    
        for (NSString* url in fileList) {
           zipUrl = [unzippedPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", url]];
                DEBUG_NSLog(@"zipUrl=%@",zipUrl);
        }
  
    
}


@end
