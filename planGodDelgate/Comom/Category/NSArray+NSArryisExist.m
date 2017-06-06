//
//  NSArray+NSArryisExist.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/28.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSArray+NSArryisExist.h"

@implementation NSArray (NSArryisExist)

-(BOOL)isExist:(NSArray*)arraySource{
    if ([arraySource count]==0||arraySource == nil) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)isNSNulNSArray{
    if ([self count]==0||self == nil) {
        return NO;
    }else{
        return YES;
    }
};

@end
