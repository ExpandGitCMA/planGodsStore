//
//  NSViewCopy.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/5/11.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSViewCopy.h"
#import "PlanConst.h"
@implementation NSViewCopy

//- (id)copyWithZone:(NSZone *)zone {
//    NSViewCopy *copy = [[NSViewCopy alloc]copyWithZone:zone];
//    return copy;
//}

//-(instancetype)copyWithZone:(NSZone *)zone{
//    NSViewCopy *copy = [[[self class]allocWithZone:zone]initWithFrame:CGRectZero URL:NULL];
//    
//    DEBUG_NSLog(@"哥们先来了哦");
//    return copy;
//}

-(instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)url{
    if (self = [super initWithFrame:frame]) {
 
         DEBUG_NSLog(@"哥们来了哦");
        
    }
    return self;
    
}

//#pragma mark - NSCopying
//- (instancetype)copyWithZone:(NSZone *)zone {
//    AFHTTPSessionManager *HTTPClient = [[[self class] allocWithZone:zone] initWithBaseURL:self.baseURL sessionConfiguration:self.session.configuration];
//    
//    HTTPClient.requestSerializer = [self.requestSerializer copyWithZone:zone];
//    HTTPClient.responseSerializer = [self.responseSerializer copyWithZone:zone];
//    HTTPClient.securityPolicy = [self.securityPolicy copyWithZone:zone];
//    return HTTPClient;
//}
//
//- (instancetype)initWithBaseURL:(NSURL *)url
//           sessionConfiguration:(NSURLSessionConfiguration *)configuration
//{
//    self = [super initWithSessionConfiguration:configuration];
//    if (!self) {
//        return nil;
//    }
//    
//    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
//    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
//        url = [url URLByAppendingPathComponent:@""];
//    }
//    
//    self.baseURL = url;
//    
//    self.requestSerializer = [AFHTTPRequestSerializer serializer];
//    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    return self;
//}
@end
