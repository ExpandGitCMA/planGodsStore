//
//  GeneralModel.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/19.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "GeneralModel.h"
#import "GoodModel.h"
#import "GoodKFCModel.h"


extern NSDictionary *GeneralModelClassUrl(){
    return @{
             Goods_FetchCatFilterList: [GoodModel class],
             Goods_GetRecommendGoods: [GoodKFCModel class]};
}

NSDictionary *GeneralModelClassMap(){
    return @{
             (id)[GoodModel class]: Goods_FetchCatFilterList,
             (id)[GoodKFCModel class]:Goods_GetRecommendGoods};
}


@implementation  GeneralWithKeyValueNSString



-(NSString*)url{
    //DEBUG_NSLog(@"url=%@",url);
    //96db9b67a65929b2d4778968def6f11a
   return   [self md5HashString:@"标签数量"];
}

- (NSString *)md5HashString: (NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", digest[0], digest[1],digest[2], digest[3],
            digest[4], digest[5],digest[6], digest[7],
            digest[8], digest[9],digest[10], digest[11],
            digest[12], digest[13],digest[14], digest[15]];
    
}


-(NSString*)key{
    NSDictionary *params = @{
                             @"name" : @"Jack",
                             @"icon" : @"lufy.png",
                             };
   //NSString*url = ZYSortedStringWithDict(params);
    return ZYSortedStringWithDict(params);
}

NSString *ZYSortedStringWithDict(NSDictionary *dict) {
    NSArray *keys = [dict allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare: obj2];
    }];
    NSMutableString *contentStr = @"".mutableCopy;
    for (NSString *key in sortedKeys) {
        id obj = dict[key];
        [contentStr appendString: key];
    }
    return contentStr;
}

-(NSDictionary*)params{
    NSDictionary *params = @{
                             @"name" : @"Jack",
                             @"icon" : @"lufy.png",
                             };
    
    //NSDictionary*dic = ZYMutableDictSimpleDeepCopy(params);
    return  ZYMutableDictSimpleDeepCopy(params);
}

NSMutableDictionary *ZYMutableDictSimpleDeepCopy(NSDictionary *params){
    NSMutableDictionary *mutableDict = @{}.mutableCopy;
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector: @selector(copy)]) {
            mutableDict[key] = [obj copy];
        } else {
            mutableDict[key] = obj;
        }
    }];
    return mutableDict;
}

BOOL ZYSignableWithObject(id obj) {
    if ([obj isKindOfClass: [NSArray class]] || [obj isKindOfClass: [NSDictionary class]]) {
        return NO;
    }
    return YES;
}

//这里以后可能改用sha-256算法，留着
- (NSString *)hashFormatStrWithData: (unsigned char *)md length: (int)length {
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++) {
        [mutableString appendFormat: @"%02x", md[i]];
    }
    return mutableString.copy;
}

- (NSString *)shaHashString: (NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cStr, (unsigned int)strlen(cStr), digest);
    return [self hashFormatStrWithData: digest length: CC_SHA256_DIGEST_LENGTH];
}

@end
