//
//  NSString+IMAdditions.m
//  IM_Expensive
//
//  Created by szcai on 15/10/14.
//  Copyright © 2015年 szcai. All rights reserved.
//

#import "NSString+IMAdditions.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (IMAdditions)
////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceOrNewLines
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary *)queryContentsUsingEncoding:(NSStringEncoding)encoding
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values) {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByAddingQueryDictionary:(NSDictionary *)query
{
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByAddingURLEncodedQueryDictionary:(NSDictionary *)query
{
    NSMutableDictionary *encodedQuery = [NSMutableDictionary dictionaryWithCapacity:[query count]];
    
    for (__strong NSString *key in [query keyEnumerator]) {
        
        NSParameterAssert([key respondsToSelector:@selector(urlEncoded)]);
        NSString *value = [query objectForKey:key];
        if ([value respondsToSelector:@selector(urlEncoded)]) {
            value = [value urlEncoded];
        } else {
            value = [NSString stringWithFormat:@"%@", value];
            value = [value urlEncoded];
        }
        
        key = [key urlEncoded];
        [encodedQuery setObject:value forKey:key];
    }
    
    return [self stringByAddingQueryDictionary:encodedQuery];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)urlEncoded
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                             (__bridge CFStringRef)self,
                                                                             NULL,
                                                                             (__bridge CFStringRef)(@":!*();@/&?#[]+$,='%’\""),
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge_transfer NSString *)cfUrlEncodedString];
    return urlEncoded;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)urlDecoded
{
    return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)trim
{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [result isEqualToString:@""] ? nil : result;
}

- (NSString *)md5Hash
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}
@end
#pragma mark - NSData+IMAdditions
/*
 * NSData+IMAdditions
 */

@implementation NSData (IMAdditions)

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)md5Hash
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (CC_LONG)[self length], result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)sha1Hash
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([self bytes], (CC_LONG)[self length], result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15],
            result[16], result[17], result[18], result[19]
            ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//
//- (NSString *)base64Encoding
//{
//    if ([self length] == 0) {
//        return @"";
//    }
//    
//    char *characters = malloc((([self length] + 2) / 3) * 4);
//    
//    if (characters == NULL) {
//        return nil;
//    }
//    
//    NSUInteger length = 0;
//    
//    NSUInteger i = 0;
//    
//    while (i < [self length]) {
//        char buffer[3] = {0, 0, 0};
//        short bufferLength = 0;
//        while (bufferLength < 3 && i < [self length]) {
//            buffer[bufferLength++] = ((char *)[self bytes])[i++];
//        }
//        
//        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
//        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
//        if (bufferLength > 1)
//            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
//        else characters[length++] = '=';
//        if (bufferLength > 2)
//            characters[length++] = encodingTable[buffer[2] & 0x3F];
//        else characters[length++] = '=';
//    }
//    
//    return [[NSString alloc] initWithBytesNoCopy:characters length:length
//                                        encoding:NSASCIIStringEncoding freeWhenDone:YES];
//    
//}
@end

@implementation NSObject (JudgeNull)
//判断对象是否为空
- (BOOL)isNull
{
    if ([self isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if ([self isKindOfClass:[NSNull class]])
        {
            return YES;
        }
        else
        {
            if (self==nil)
            {
                return YES;
            }
        }
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    return NO;
}

@end
