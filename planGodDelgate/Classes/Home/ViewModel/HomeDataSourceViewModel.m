//
//  HomeDataSourceViewModel.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/7.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "HomeDataSourceViewModel.h"
#import "PlanColorDef.h"
#import "NSString+IMAdditions.h"
#import "GoodModel.h"
@interface HomeDataSourceViewModel ()<NSURLSessionDelegate>{
    NSURLSession *_resumeSession;
    NSURLSessionDownloadTask *_resumeTask;
    NSData *_resumeData;
    NSURLSessionDownloadTask *_downloadTask ;
     NSURLSession *_backgroundSession;
}
@property(nonatomic,strong)NSMutableArray*arraySource;
@end

@implementation HomeDataSourceViewModel

+(NSArray<NSObject *>*)parseWithJson:(NSArray *)list{
    NSMutableArray *arraySource = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in list) {
             NSObject*model = [[NSObject alloc]init];
             [model setValuesForKeysWithDictionary:dic];
             [arraySource addObject:model];
    }
    return [arraySource copy];
}

-(void)downloadBannerUrl{
    [self getFilePathWith];
    [self requestBanner];
}

/*
 *@获取首页Banner数据
 *@Day 2016.11.21
 */
-(void)requestBanner{
    [[NetworkManager shareNetworkManager]getWithURL:urlSubject WithParmeters:nil compeletionWithBlock:^(id obj) {
        for (NSDictionary *dic in obj) {
            NSString*banner = [[NSString alloc]init];
            banner =  [dic objectForKey:@"home_banner"];
            //[self downloadAdImageWithUrl:banner];
            [self downloaTaskWithImageUrl:banner];
        }
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark- NSURLSessionDownloadTask下载图片
- (void)downloaTaskWithImageUrl:(NSString *)imageUrl{
    //判断一个给定路径是否为文件夹,创建文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self docPathcacheFolder]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[self docPathcacheFolder] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSURL *imgUrl = [NSURL URLWithString:imageUrl];
    NSURLSession *ImgSession = [NSURLSession sharedSession];

    NSURLSessionDownloadTask*ImgDownTask  = [ImgSession downloadTaskWithURL:imgUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
         NSString *fileName = [[[response.suggestedFilename dataUsingEncoding:NSUTF8StringEncoding] md5Hash] stringByAppendingPathExtension:@"png"];
        NSString *cachePath = [[self docPathcacheFolder]stringByAppendingPathComponent:fileName];
        
        //移动到文件夹下
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:cachePath] error:NULL];
    }];
    [ImgDownTask resume];
}
#pragma mark- NSURLSessionDownloadTask下载大文件
/* 创建一个后台session单例 */
- (NSURLSession *)backgroundSession {
    if (!_backgroundSession) {
        // id = 时间戳加主键
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSString *sessionID = [NSString stringWithFormat:@"%f%@", timeInterval, @"DFC"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:sessionID];
        _backgroundSession = [NSURLSession sessionWithConfiguration:config  delegate:self delegateQueue:nil];
        _backgroundSession.sessionDescription = sessionID;
    }
    
    return _backgroundSession;
}
-(void)downLoadBigFile{
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"https://moa.ch999.com/office/file/2b7d301dfc75be810fb5dda9f6920726d41d8cd98f00b204e9800998ecf8427e.mp4"]];
    [downloadTask resume];
}

- (void)cancelDownload {
    [_downloadTask cancel];
    _downloadTask = nil;
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    // 信任
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    DEBUG_NSLog(@"下载成功");
}

/* 从fileOffset位移处恢复下载任务 */
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    DEBUG_NSLog(@"NSURLSessionDownloadDelegate: Resume download at %lld", fileOffset);
}
/*
 *@监测临时文件下载的数据大小
 *@bytesWritten 单次写入多少
 *@totalBytesWritten 已经写入了多少
 *@totalBytesExpectedToWrite 文件总大小
 *@Day 2017.05.18
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //打印下载百分比
    NSLog(@"已下载%f%%",totalBytesWritten * 1.0 / totalBytesExpectedToWrite * 100);
}

/*
 *@大文件下载成功
 *@Day 2017.05.18
 *@ 完成下载任务，只有下载成功才调用该方法
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *catchPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:catchPath] error:NULL];
}

/* 完成下载任务，无论下载成功还是失败都调用该方法 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%@",error);
    DEBUG_NSLog(@"NSURLSessionDownloadDelegate: Complete task");
}


#pragma mark- NSURLSession 文件上传
-(void)uploadFile{
    NSURL *uploadUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.9ji.com/app/3_0/UserHandler.ashx?act=UploadImage"]];
    
    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:uploadUrl];
    
    uploadRequest.HTTPMethod = @"POST";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"boundary"];
    
    [uploadRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    UIImage *image = [UIImage imageNamed:@"图片1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"图片2.jpg"];
    
    NSMutableArray *imaArr = [[NSMutableArray alloc]init];
    [imaArr addObject:image];
    [imaArr addObject:image2];
    
    uploadRequest.HTTPBody = [self getDataBodyWithImgArr:imaArr];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:uploadRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            UILabel *textLbl ;
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            dispatch_async(dispatch_get_main_queue(), ^{
                textLbl.text = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            });
        } else {
            NSLog(@"upload error:%@",error);
        }
        
    }] resume];

}
-(NSData *)getDataBodyWithImgArr:(NSArray *)imgArr{
    //每个文件上传须遵守W3C规则进行表单拼接
    NSMutableData * data=[NSMutableData data];
    
    for (int i = 0; i < imgArr.count; i++) {
        NSMutableString *headerStrM =[NSMutableString string];
        [headerStrM appendFormat:@"\r\n--%@\r\n",@"boundary"];
        [headerStrM appendFormat:@"Content-Disposition: form-data; name=\"file%d\"; filename=\"filename%d\"\r\n",i,i];
        [headerStrM appendFormat:@"Content-Type: application/octet-stream\r\n\r\n"];
        [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *imgData = UIImageJPEGRepresentation(imgArr[i], 0.5);
        [data appendData:imgData];
    }
    
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",@"boundary"];
    [data appendData:[footerStrM  dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

#pragma mark- NSURLSession 断点续传
//点击任务开始
-(void)pressPR:(UIButton *)sender{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    _resumeSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    _resumeTask = [_resumeSession downloadTaskWithURL:[NSURL URLWithString:@"https://moa.ch999.com/office/file/2b7d301dfc75be810fb5dda9f6920726d41d8cd98f00b204e9800998ecf8427e.mp4"]];
    [_resumeTask resume];
}

//点击暂停任务挂起
-(void)pressPause:(UIButton *)sender{
    UIButton *resumeBtn ;
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    resumeBtn.userInteractionEnabled = YES;
    resumeBtn.selected = NO;
    
    //将任务挂起
    [_resumeTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //将已下载的数据进行保存
        _resumeData = resumeData;
    }];
}
//点击继续
-(void)pressResume:(UIButton *)sender{
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    UIButton *pauseBtn;
    pauseBtn.userInteractionEnabled = YES;
    pauseBtn.selected = NO;
    
    //使用rusumeData创建任务
    _resumeTask = [_resumeSession downloadTaskWithResumeData:_resumeData];
    
    [_resumeTask resume];
}

/*
 *@下载新图片
 *@Day 2016.11.21
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl{
    //判断一个给定路径是否为文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self docPathcacheFolder]]) {[[NSFileManager defaultManager] createDirectoryAtPath:[self docPathcacheFolder] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *fileName = [[[imageUrl dataUsingEncoding:NSUTF8StringEncoding] md5Hash] stringByAppendingPathExtension:@"png"];
        NSString *cacheFile = [[self docPathcacheFolder] stringByAppendingPathComponent:fileName];
        //将图片写入文件夹缓存
        if ([UIImageJPEGRepresentation(image, 0.6) writeToFile:cacheFile atomically:YES]) {
            DEBUG_NSLog(@"下载保存成功");
            DEBUG_NSLog(@"%@",[self docPathcacheFolder]);
        }else{
            DEBUG_NSLog(@"下载保存失败");
        }
    });
}
/*
 *  获取本地图片等文件路径
 */
- (void)getFilePathWith{
    NSString *path = [self docPathcacheFolder];
    //创建一个新的NSFileManager*实例,每次调用返回一个不同的指针地址,保证线程安全
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *enumerator;
    enumerator = [fileManager enumeratorAtPath:path];
    while((path = [enumerator nextObject]) != nil) {
        if (![path isEqualToString:@".DS_Store"]) {
            NSString*url = [NSString stringWithFormat:@"%@%@%@",[self docPathcacheFolder],@"/",path];
            [self deleteOldImage:url];
        }
    }
    
}
/**
 *  删除旧图片
 */
- (void)deleteOldImage:(NSString*)url{
    DEBUG_NSLog(@"删除本地图片%@",url);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:url error:nil];
}

-(NSString*)docPathcacheFolder{
    //获取指定沙盒目录
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docPath = [paths objectAtIndex:0];
//    NSString *cacheFolder = [docPath stringByAppendingPathComponent:IMAGECACHE_FOLDERNAME_CACHE];
//    
//    return cacheFolder;
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    return [paths stringByAppendingPathComponent:IMAGECACHE_FOLDERNAME_CACHE];
}



@end
