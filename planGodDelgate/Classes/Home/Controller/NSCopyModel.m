//
//  NSCopyModel.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/12.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSCopyModel.h"
#import <UIKit/UIKit.h>
#define kCacheTotalCostLimit 10*1024*1024   // 设置缓存区域大小为10M

@interface NSCopyModel ()<NSCacheDelegate>

@end

@implementation NSCopyModel
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] allocWithZone:zone];
}

-(void)setName:(NSString *)name{
      _name = [name copy];
}


-(void)saveNSCache{

    NSCache*cache = [[NSCache alloc] init];
    cache.totalCostLimit = kCacheTotalCostLimit;
    cache.delegate = self;
    // cache.countLimit = 30;   设置缓存条数30条
    [cache setObject:@"要缓存的对象，可以是image"  forKey:@"可以用图片的url或者名称作为key值"];
    // 向缓存中写数据 在需要使用图片的地方
    UIImage *image = [cache objectForKey:@"刚才设置的key值"];
    if (image==nil) {
        image = [UIImage imageWithContentsOfFile:@"图片地址"];
        // 如果缓存中没有图片就去图片位置去获取一次，下次只要缓存没有清除就不需要再去获取了
    }
    
    //cache setObject:<#(nonnull id)#> forKey:<#(nonnull id)#>
    
}



- (void)removeAllObjects{

}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
 // 操作即将删除的缓存内容
}
@end
