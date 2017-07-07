//
//  GoodModel.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

/*
 Nonnull区域设置(Audited Regions)
 如果需要每个属性或每个方法都去指定nonnull和nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了两个宏：NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END。在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。如下代码所示：
 */
#import <Foundation/Foundation.h>
#import "NSString+IMAdditions.h"

NS_ASSUME_NONNULL_BEGIN
@interface GoodModel : NSObject
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*userCodel;
@property(nonatomic,copy)NSString*imageUrl;
@property(nonatomic,copy)NSString*goodsNname;
@property(nonatomic,copy)NSString*price;
- (id)itemWithName:(nullable NSString *)name; 
+(NSMutableArray<GoodModel *>*)parseWithJson:(NSArray *)list;
@end

NS_ASSUME_NONNULL_END

