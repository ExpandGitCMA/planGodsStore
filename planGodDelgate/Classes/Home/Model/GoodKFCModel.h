//
//  GoodKFCModel.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/25.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodKFCModel : NSObject
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * icon;
+(instancetype)parseWithJson:(NSDictionary *)dict;
+(NSArray*)parseWithDict:(NSDictionary *)dict;
@end
