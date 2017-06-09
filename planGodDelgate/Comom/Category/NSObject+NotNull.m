//
//  NSObject+NotNull.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/9.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSObject+NotNull.h"

@implementation NSObject (NotNull)

-(BOOL)isNotNull{
    if (self ==nil ||self ==NULL|| (NSNull *)self==[NSNull null]) {
        return NO;
    }
    return YES;
}

-(BOOL)isNotEmpty{
    BOOL empty = YES;
    if([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]){
        if ([(NSArray *)self count]==0||self == nil ||self == NULL|| (NSNull *)self==[NSNull null]) {
            empty = NO;
        }
    }

    if([self isKindOfClass:[NSSet class]] || [self isKindOfClass:[NSMutableSet class]]){
        if ([(NSSet *)self count]==0||self == nil ||self == NULL|| (NSNull *)self==[NSNull null]) {
            empty = NO;
        }
    }
    
    if([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]){
        if ([(NSDictionary *)self count]==0||self == nil ||self == NULL|| (NSNull *)self==[NSNull null]) {
            empty = NO;
        }
    
    }

    if([self isKindOfClass:[NSString class]] ||[self isKindOfClass:[NSMutableString class]]){
        if ( [(NSString *)self length]==0 ||[(NSString *)self isEqualToString:@" "]||self == nil ||self == NULL || (NSNull *)self==[NSNull null]) {
             empty = NO;
        }
    }

    if (self ==nil ||self ==NULL|| (NSNull *)self==[NSNull null]) {
        empty = NO;
    }
    
    return empty;
}

#pragma mark 包大小转换工具类（将包大小转换成合适单位）
-(NSString *)getDataSizeString:(int) nSize
{
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%dB", nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
    }
    else	// >1G
    {
        string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
    }
    
    return string;
}

#pragma mark - 16进制颜色转换
+(UIColor *)getRGBColor:(NSString *)hexColor{
    unsigned int red, green, blue;
    if([hexColor length]!=7){
        NSLog(@"非7位16进制字符串,正确格式为#000000");
        return nil;
    }
    NSRange range;
    range.length =2;
    range.location =1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
