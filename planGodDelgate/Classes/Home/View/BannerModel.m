//
//  BannerModel.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/2.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
+(NSMutableArray*)parseWithJson:(NSArray *)list{
    NSMutableArray *arrayList = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in list) {
        BannerModel*model = [[self alloc]init];
        model.imageUrl = [dic objectForKey:@"home_banner"];
        [arrayList addObject: model];
    }
    return arrayList;
}
@end
