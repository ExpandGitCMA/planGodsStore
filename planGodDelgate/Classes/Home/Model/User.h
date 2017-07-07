//
//  User.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/14.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface User : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (nonatomic, copy) NSDictionary *modelClassMap;
@property (nonatomic, copy) NSDictionary *modelClassUrl;
@property (assign, nonatomic, getter=isGay) BOOL gay;
+(User*)jsonWithKeyValuesModel;
+(NSArray<NSObject *>*)parseWithJson:(NSArray *)list;

/*
 User *mdeol = [[User alloc]init];
 mdeol.modelClassMap = GeneralModelClassMap();
 NSString *url = [mdeol.modelClassMap   objectForKey:[GoodModel class]];
 NSObject *class = [mdeol.modelClassMap  objectForKey:Goods_FetchCatFilterList];
 DEBUG_NSLog(@"url=%@,class=%@",url,class);
 //url=/goods/fetchCatSkuList.do,class=(null)
 */

@end


@interface Status : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Status *retweetedStatus;
+(Status*)modelWithKeyValuesModel;
@end


@interface Ad : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;
@end
@interface StatusResult : NSObject
/** Contatins status model */
@property (strong, nonatomic) NSMutableArray *statuses;
/** Contatins ad model */
@property (strong, nonatomic) NSArray *ads;
@property (strong, nonatomic) NSNumber *totalNumber;
+(void)modelWithModelKeyValuesNSArray;
@end


@interface Bag : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *runSpeed;
@property (assign, nonatomic) double price;
@end
@interface Student : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) Bag *bag;
+(void)modelWithNameKeyJSONkeyValues;
@end

