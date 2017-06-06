//
//  NetworkManager.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanConst.h"
typedef void(^NetworkManagerBlock)(id obj);
typedef void (^failed)(NSError *error);

@interface NetworkManager : NSObject
@property (nonatomic, assign) NSInteger  networkStatus;
+(instancetype)shareNetworkManager;
- (void)networkReaching;

- (void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkManagerBlock)block failed:(failed)failed;
@end
