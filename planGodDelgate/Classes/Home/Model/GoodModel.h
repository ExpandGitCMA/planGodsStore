//
//  GoodModel.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+IMAdditions.h"

@interface GoodModel : NSObject
@property(nonatomic,copy)NSString*userCodel;
@property(nonatomic,copy)NSString*imageUrl;
@property(nonatomic,copy)NSString*goodsNname;
@property(nonatomic,copy)NSString*price;
+(NSMutableArray<GoodModel *>*)parseWithJson:(NSArray *)list;
@end
