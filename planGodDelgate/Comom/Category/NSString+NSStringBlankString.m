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

-(void)isNSNulstring:(NSString*)string{
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        // 是数字
    } else{
        // 不是数字
    }
}

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

#pragma mark Private
/**
 计算字符串长度
 
 @param string string
 @param font font
 @return 字符串长度
 */
+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
@end
