//
//  HistoryArchive.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "HistoryArchive.h"
#import <objc/runtime.h>


static NSString * const kHistoryArchiveKey = @"historyArchive";
@implementation HistoryArchive
- (NSString *)cacheDir{
    NSString *addressPath=[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject],@"cache1"];
    return addressPath;
    
}

//保存NSDictionary 与归档
-(void)saveDictionary:(NSDictionary *)dict {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:kHistoryArchiveKey];
    // archivingData的encodeWithCoder
    [archiver finishEncoding];
    //写入文件
    [data writeToFile:[self cacheDir] atomically:YES];
}

//解档得到NSDictionary
- (NSDictionary *)loadArchives{
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self cacheDir]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSDictionary  *archivingData = [unarchiver decodeObjectForKey:kHistoryArchiveKey];
    // initWithCoder方法被调用
    [unarchiver finishDecoding];
    return archivingData;
}


//Runtime对象的序列化&反序列化
//当我们归档这个对象的时候就会来到这里!!
- (void)encodeWithCoder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([HistoryArchive class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        //kvc 获取属性的值
        id value = [self valueForKey:key];
        //归档!!
        [coder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([HistoryArchive class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:key];
            //设置到属性上面  kvc
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


//- (IBAction)save:(id)sender {
//    Person * p = [[Person alloc]init];
//    
//    p.name = @"hank";
//    p.age = 18;
//    
//    //路径
//    NSString * temp  = NSTemporaryDirectory();
//    NSString * filePath = [temp stringByAppendingPathComponent:@"hank.data"];
//    
//    [NSKeyedArchiver archiveRootObject:p toFile:filePath];
//    
//}

//- (IBAction)read:(id)sender {
//    //路径
//    NSString * temp  = NSTemporaryDirectory();
//    NSString * filePath = [temp stringByAppendingPathComponent:@"hank.data"];
//    
//    Person * p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    
//    NSLog(@"%@老师.今年%d岁了!!",p.name,p.age);
//    
//}

@end
