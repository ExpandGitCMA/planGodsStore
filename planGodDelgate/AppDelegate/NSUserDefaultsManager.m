//
//  NSUserDefaultsManager.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/20.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "NSUserDefaultsManager.h"
#import "PlanConst.h"
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
static NSString *const presentTimerCache = @"presentTimerCache";
@interface NSUserDefaultsManager()
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@end

@implementation NSUserDefaultsManager
+(NSUserDefaultsManager *)shareManager{
    static NSUserDefaultsManager *userDefMag = nil;
    if (userDefMag == nil) {
        static dispatch_once_t dispatch;
        dispatch_once(&dispatch, ^{
            userDefMag = [[self alloc]init];
        });
    }
    return userDefMag;
}

-(NSUserDefaults *)getUserDefaults{
    if (_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

-(void)setApresentTimer:(NSString *)presentTimer{
    if (presentTimer != nil) {
        NSUserDefaults* user = [self getUserDefaults];
        [user setObject:presentTimer forKey:presentTimerCache];
        [user synchronize];
    }
}

-(NSString*)getApresentTimer{
    NSUserDefaults* user = [self getUserDefaults];
    NSString* presentTimer = [user objectForKey:presentTimerCache];
    return presentTimer;
}

/*
 * 判断沙盒中是否存在广告图片，如果存在，直接显示
 */
-(NSString*)getfilePath{
    NSString *filePath = [self getFilePathWithImageName:[[self getUserDefaults] valueForKey:adImageName]];
    return filePath;
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

- (void)getAdvertisingImage{
    // 获取广告图片
    NSArray *imgLaunch = @[@"http://img1.126.net/channel6/2015/ad/2_1224a.jpg",@"http://pic2.16pic.com/00/07/27/16pic_727996_b.jpg",@"http://pic.downcc.com/upload/2016-8/2016820123739219310.jpeg",@"http://pic.qiantucdn.com/58pic/18/22/63/71D58PIC4eC_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498135444861&di=1095df79abd21cbde8325517cd699c55&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01c2a355ebd6736ac7251df8445de5.jpg"];
    
    //随机获取图片
    NSString *imageUrl = imgLaunch[arc4random() % imgLaunch.count];
    // 获取图片名
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
     DEBUG_NSLog(@"filePath==%@",filePath);
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
    
}


/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        DEBUG_NSLog(@"保存成功=%@",filePath);
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            [self deleteOldImage];
            [[self getUserDefaults] setValue:imageName forKey:adImageName];
            [[self getUserDefaults] synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            DEBUG_NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage{
    NSString *imageName = [[self getUserDefaults] valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/*
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

//删除NSUserDefaults所有记录
-(void)removeDefaults{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

//方法二
- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}
// 方法三
-(void)removeDictUsefaults{
     [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end
