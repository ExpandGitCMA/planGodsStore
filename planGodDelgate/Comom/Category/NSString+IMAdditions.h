//
//  NSString+IMAdditions.h
//  IM_Expensive
//
//  Created by szcai on 15/10/14.
//  Copyright © 2015年 szcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IMAdditions)
/**
 * 检查是否字符串仅包含空格或换行
 */
- (BOOL)isWhitespaceOrNewLines;

/**
 * 解析URL查询串
 */
- (NSDictionary *)queryContentsUsingEncoding:(NSStringEncoding)encoding;

/**
 * 组合参数到URL上
 */
- (NSString *)stringByAddingQueryDictionary:(NSDictionary *)query;

/**
 * 组合urlencode后的参数到URL上
 * 此方法会使用[NSString urlEncoded]对参数的key和value进行编码
 *
 * @throw NSInvalidArgumentException 如果使用urlencode对key或value编码出错
 */
- (NSString *)stringByAddingURLEncodedQueryDictionary:(NSDictionary *)query;

/**
 * 对字符串进行url编码
 */
- (NSString *)urlEncoded;

/**
 * 对字符串进行url解码
 */
- (NSString *)urlDecoded;

/**
 * 去掉字符串头尾的空格
 */
- (NSString *)trim;


/**
 * 计算MD5值
 */
@property (nonatomic, readonly) NSString *md5Hash;
@end

/**
 * NSData+KTAdditions
 */
@interface NSData (IMAdditions)

/**
 * 使用CC_MD5计算md5
 */
@property (nonatomic, readonly) NSString *md5Hash;

/**
 * 使用CC_SHA1计算sha1
 */
@property (nonatomic, readonly) NSString *sha1Hash;

/**
 被定义在@interface NSData (NSDeprecated)
 * 将数据转换成base64字符串
 */
//- (NSString *)base64Encoding;

@end

@interface NSObject (JudgeNull)
- (BOOL)isNull;
@end

