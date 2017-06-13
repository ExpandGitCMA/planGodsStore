//
//  NetworkManager.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "PlanConst.h"
#import "NetworkLoading.h"
#define NetWork_TimeOut  25
@interface NetworkManager ()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@property (nonatomic, strong)NetworkLoading *viewOptLoading; 
@property (nonatomic, strong)NSString *netStatus;
@end

@implementation NetworkManager

+ (id)allocWithZone:(NSZone *)zone{
    return [self shareNetworkManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[NetworkManager allocWithZone:zone] init];
}
+(instancetype)shareNetworkManager{
    static NetworkManager *network = nil;
    if (network==nil) {
        static dispatch_once_t dispatch;
        dispatch_once(&dispatch , ^{ network = [[super allocWithZone:NULL] init];
        });
    }
    return network;
}

-(NetworkLoading*)viewOptLoading{
    if (!_viewOptLoading) {
        _viewOptLoading = [[NetworkLoading alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[[UIApplication sharedApplication] windows].lastObject addSubview:_viewOptLoading];
    }
    return _viewOptLoading;
}

-(instancetype)init{
    if (self=[super init]) {
        self.netStatus = [NSString string];
    }
    return self;
}

- (AFHTTPSessionManager *)getManager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager  manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer]; //序列化请求参数(Json)
        _manager.requestSerializer.timeoutInterval = NetWork_TimeOut;
    }
    return _manager;
}

- (void)networkReaching{

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *mNetworkStatus = [NSString string];
        switch (status) {
            case -1:
                mNetworkStatus = @"Unknown";
                break;
            case 0:
                mNetworkStatus = @"NotReachable";
                break;
            case 1:
                mNetworkStatus = @"WWAN";
                break;
            case 2:
                mNetworkStatus = @"WiFi";
                break;
            default:
                break;
        }
        if (self.netStatus) {
            if (![self.netStatus isEqualToString:mNetworkStatus]) {//网络状态发生变化，拋一个通知出来
                self.netStatus = mNetworkStatus;
            }
        }else{
            
            self.netStatus = mNetworkStatus;
        }
        _networkStatus = status;
        DEBUG_NSLog(@"当前网络状态 = %@",self.netStatus);
    }];
    
}

- (void)httpGetRequest:(NSString *)urlString paramters:(NSDictionary *)paramters success:(NetworkManagerBlock)success failed:(failed)failed{
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[self getManager] GET:url.absoluteString parameters:paramters progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
        [_viewOptLoading stopLoading];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error.description);
        if (failed) {
            failed(error);
        }
          [_viewOptLoading stopLoading];
    }];

}

- (void)httpPostRequest:(NSString *)urlString paramters:(NSDictionary *)paramters success:(NetworkManagerBlock)success failed:(failed)failed{
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[self getManager]POST:url.absoluteString parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (responseObject) {
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error.description);
        if (failed) {
            failed(error);
        }
    }];


}


-(void)getWithURL:(NSString *)urlString WithParmeters:(NSDictionary *)dictionary compeletionWithBlock:(NetworkManagerBlock)block failed:(failed)failed{
    [self httpGetRequest:urlString paramters:dictionary success:block failed:failed];
    //加载网络状态
     [self viewOptLoading];
}


@end
