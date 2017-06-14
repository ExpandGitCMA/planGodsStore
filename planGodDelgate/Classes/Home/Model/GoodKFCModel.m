//
//  GoodKFCModel.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/25.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "GoodKFCModel.h"
#import "MJExtension.h"
@implementation GoodKFCModel

+(instancetype)parseWithJson:(NSDictionary *)dict{

    GoodKFCModel *good = [[GoodKFCModel alloc]init];
    [good  setValuesForKeysWithDictionary:dict];
    return good;

}

+(NSArray*)parseWithDict:(NSDictionary *)dict{
    
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"kfc.plist" ofType:nil];
    NSArray *  list = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray*arraySource = [[NSMutableArray alloc]init];
    
//        for (NSDictionary *dic in list) {
//             GoodKFCModel *good = [[GoodKFCModel alloc]init];
//             [good  setValuesForKeysWithDictionary:dic];
//              [arraySource addObject:good];
//              NSLog(@"name==%@",good.name);
//        }

    NSArray *userArray = [GoodKFCModel mj_objectArrayWithKeyValuesArray:list];
    // Printing
    for (GoodKFCModel *good in userArray) {
           NSLog(@"name==%@",good.name);
            [arraySource addObject:good];
    }
    
    return [arraySource copy];
}

@end
