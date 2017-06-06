//
//  NSString+NSStringBlankString.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/28.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSString+NSStringBlankString.h"

static NSUInteger  const rowHeight = 200;

@implementation NSString (NSStringBlankString)

- (BOOL)isNSNulString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)sizeWithForRowHeight{
    CGSize titleSize=[self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return rowHeight+titleSize.height;
}

@end
