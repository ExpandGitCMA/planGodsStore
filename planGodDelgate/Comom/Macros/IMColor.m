//
//  IMColor.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/2.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "IMColor.h"

@implementation UIColor(IMColor)
@end

@implementation DFCPerson
-(void)setLastName:(NSString *)lastName{
}
-(void)setFirstName:(NSString *)firstName{
}

-(void)xxx{
//获取这些目录路径的方法： 1，获取家目录路径的函数：
    //NSString *homeDir = NSHomeDirectory();
    //2，获取Documents目录路径的方法：
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); NSString *docDir = [paths objectAtIndex:0];
    //3，获取Caches目录路径的方法：
    //NSArray *pathsCaches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); NSString *cachesDir = [paths objectAtIndex:0];
    //4，获取tmp目录路径的方法：
    //NSString *tmpDir = NSTemporaryDirectory();
    //5，获取应用程序程序包中资源文件路径的方法： 例如获取程序包中一个图片资源（apple.png）路径的方法：
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
   // UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    //代码中的mainBundle类方法用于返回一个代表应用程序包的对象。
}

@end
