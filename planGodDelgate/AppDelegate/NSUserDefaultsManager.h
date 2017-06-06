//
//  NSUserDefaultsManager.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/20.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSUserDefaultsManager : NSObject
+(NSUserDefaultsManager *)shareManager;
-(NSString*)getfilePath;
- (BOOL)isFileExistWithFilePath:(NSString *)filePath;
- (void)getAdvertisingImage;

/**
 * 缓存获取日前时间戳
 */
-(void)setApresentTimer:(NSString *)presentTimer;
-(NSString *)getApresentTimer;

@end
