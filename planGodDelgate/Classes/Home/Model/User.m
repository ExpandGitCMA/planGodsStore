//
//  User.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/14.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "User.h"
#import "MJExtension.h"
#import "PlanConst.h"

@implementation Bag
//归档解档
+(void)coding{
    [Bag mj_setupIgnoredCodingPropertyNames:^NSArray *{
        return @[@"name"];
    }];
    // Equals: Bag.m implements +mj_ignoredCodingPropertyNames method.
    // Create model
    Bag *bag = [[Bag alloc] init];
    bag.name = @"Red bag";
    bag.price = 200.8;
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/bag.data"];
    // Encoding
    [NSKeyedArchiver archiveRootObject:bag toFile:file];
    // Decoding
    Bag *decodedBag = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSLog(@"name=%@, price=%f", decodedBag.name, decodedBag.price);
    // name=(null), price=200.800000
}


// Camel -> underline【统一转换属性名（比如驼峰转下划线）】
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName mj_underlineFromCamel];
}
+(void)xx{
    NSDictionary *dict = @{
                           @"nick_name" : @"旺财",
                           @"sale_price" : @"10.5",
                           @"run_speed" : @"100.9"
                           };
    // NSDictionary -> Dog
    Bag *dog = [Bag mj_objectWithKeyValues:dict];
    // printing
    NSLog(@"nickName=%@, scalePrice=%f runSpeed=%@", dog.name, dog.price, dog.runSpeed);
}
//NSString -> NSDate, nil -> @""【过滤字典的值（比如字符串日期处理为NSDate、字符串nil处理为@""）】
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}
+(void)yetxs{
    // NSDictionary
    NSDictionary *dict = @{
                           @"name" : @"5分钟突破iOS开发",
                           @"publishedTime" : @"2011-09-10"
                           };
    // NSDictionary -> Book
    Bag *book = [Bag mj_objectWithKeyValues:dict];
    // printing
    NSLog(@"name=%@, publisher=%@", book.name, book.runSpeed);
}
@end

@implementation Student
// Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
+(void)modelWithNameKeyJSONkeyValues{
    [Student mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"desc" : @"desciption",
                 @"oldName" : @"name.oldName",
                 @"nowName" : @"name.newName",
                 @"nameChangedTime" : @"name.info[1].nameChangedTime",
                 @"bag" : @"other.bag"
                 };
    }];
    // Equals: Student.m implements +mj_replacedKeyFromPropertyName method.
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"kids",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{
                                               @"nameChangedTime" : @"2013-08"
                                               }
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"a red bag",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    // JSON -> Student
    Student *stu = [Student mj_objectWithKeyValues:dict];
    // Printing
    NSLog(@"ID=%@, desc=%@, oldName=%@, nowName=%@, nameChangedTime=%@",
          stu.ID, stu.desc, stu.oldName, stu.nowName, stu.nameChangedTime);
    // ID=20, desc=kids, oldName=kitty, nowName=lufy, nameChangedTime=2013-08
    NSLog(@"bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
    // bagName=a red bag, bagPrice=100.700000
    
}
@end

@implementation User


+(NSArray<NSObject *>*)parseWithJson:(NSArray *)list{
    NSMutableArray *arraySource = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in list) {
        NSObject*model = [[NSObject alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arraySource addObject:model];
    }
    return [arraySource copy];
}


//JSON -> User
+(User*)jsonWithKeyValuesModel{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.55",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           };
    User *user = [User mj_objectWithKeyValues:dict];
    DEBUG_NSLog(@"user==%@",user);
    return user;
}
// JSON array -> model array【将一个字典数组转成模型数组】
+(void)jsonWithKeyModelNSArray{

    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    // JSON array -> User array
    NSArray *userArray = [User mj_objectArrayWithKeyValuesArray:dictArray];
    // Printing
    for (User *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);
    }
    // name=Jack, icon=lufy.png
    // name=Rose, icon=nami.png
}
//Model -> JSON【将一个模型转成字典】
+(void)modelWithKeyValuesJSON{
    // New model
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    Status *status = [[Status alloc] init];
    status.user = user;
    status.text = @"Nice mood!";
    // Status -> JSON
    NSDictionary *statusDict = status.mj_keyValues;
    NSLog(@"%@", statusDict);
    /*
     {
     text = "Nice mood!";
     user =     {
     icon = "lufy.png";
     name = Jack;
     };
     }
     */
    // More complex situation
    Student *stu = [[Student alloc] init];
    stu.ID = @"123";
    stu.oldName = @"rose";
    stu.nowName = @"jack";
    stu.desc = @"handsome";
    stu.nameChangedTime = @"2018-09-08";
    Bag *bag = [[Bag alloc] init];
    bag.name = @"a red bag";
    bag.price = 205;
    stu.bag = bag;
    NSDictionary *stuDict = stu.mj_keyValues;
    NSLog(@"%@", stuDict);
    /*
     {
     ID = 123;
     bag =     {
     name = "\U5c0f\U4e66\U5305";
     price = 205;
     };
     desc = handsome;
     nameChangedTime = "2018-09-08";
     nowName = jack;
     oldName = rose;
     }
     */
}

+(void) coreData{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           };
    // This demo just provide simple steps
    NSManagedObjectContext *context = nil;
    User *user = [User mj_objectWithKeyValues:dict context:context];
    [context save:nil];
}

@end

@implementation Status
// Model contains model【模型中嵌套模型】
+(Status*)modelWithKeyValuesModel{
    NSDictionary *dict = @{
                           @"text" : @"Agree!Nice weather!",
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           @"retweetedStatus" : @{
                                   @"text" : @"Nice weather!",
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    // JSON -> Status
    Status *status = [Status mj_objectWithKeyValues:dict];
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
    DEBUG_NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    // text=Agree!Nice weather!, name=Jack, icon=lufy.png
    NSString *text2 = status.retweetedStatus.text;
    NSString *name2 = status.retweetedStatus.user.name;
    NSString *icon2 = status.retweetedStatus.user.icon;
    DEBUG_NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
    // text2=Nice weather!, name2=Rose, icon2=nami.png
    
    return status;
}
@end

@implementation Ad

@end

@implementation StatusResult
// Model contains model-array【模型中有个数组属性，数组里面又要装着其他模型】
+(void)modelWithModelKeyValuesNSArray{

    [StatusResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"Status",
                 // @"statuses" : [Status class],
                 @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
    // Equals: StatusResult.m implements +mj_objectClassInArray method.
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };
    // JSON -> StatusResult
    StatusResult *result = [StatusResult mj_objectWithKeyValues:dict];
    NSLog(@"totalNumber=%@", result.totalNumber);
    // totalNumber=2014
    // Printing
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    // text=Nice weather!, name=Rose, icon=nami.png
    // text=Go camping tomorrow!, name=Jack, icon=lufy.png
    // Printing
    for (Ad *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
    // image=ad01.png, url=http://www.ad01.com
    // image=ad02.png, url=http://www.ad02.com
}

@end

