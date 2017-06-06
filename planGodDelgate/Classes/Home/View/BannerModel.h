//
//  BannerModel.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/2.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property(nonatomic,copy)NSString*imageUrl;
+(NSMutableArray*)parseWithJson:(NSArray*)list;
@end
