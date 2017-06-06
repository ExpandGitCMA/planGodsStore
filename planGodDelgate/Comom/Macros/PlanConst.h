//
//  PlanConst.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#ifndef PlanConst_h
#define PlanConst_h
#import "AFNetworking.h"
//在程序初始化，获取屏幕宽高
#define SCREEN_WIDTH  ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//#ifdef DEBUG
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(format, ...)
//#endif

#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif




#ifdef DEBUG
#define DEBUG_NSLog(format, ...) NSLog(format, ##__VA_ARGS__)
#else
#define DEBUG_NSLog(format, ...)
#endif

#define urlGoods   @"http://apiv2.yangkeduo.com/v2/goods?"
#define urlSubject @"http://apiv2.yangkeduo.com/subjects"

//无网络状态
//#define  Network   (([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) ==AFNetworkReachabilityStatusNotReachable)

//(([[NetworkManager shareNetworkManager]netStatus]) == AFNetworkReachabilityStatusNotReachable)
#define WINDOW ([[UIApplication sharedApplication] windows].lastObject)

#define CM(X,Y,W,H)  CGRectMake(X, Y, W, H)
#endif /* PlanConst_h */
