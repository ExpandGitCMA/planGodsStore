//
//  GoodKFCModel.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/25.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "GoodKFCModel.h"

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
    
    
        for (NSDictionary *dic in list) {
             GoodKFCModel *good = [[GoodKFCModel alloc]init];
             [good  setValuesForKeysWithDictionary:dic];
              [arraySource addObject:good];
              NSLog(@"name==%@",good.name);
        }

    return [arraySource copy];
}

@end
