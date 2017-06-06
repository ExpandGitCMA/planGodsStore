//
//  GoodModel.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "GoodModel.h"
#import "PlanConst.h"
#import "DAOManager.h"

@implementation GoodModel

+(NSMutableArray<GoodModel *>*)parseWithJson:(NSArray *)list{
    NSMutableArray *arrayList = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in list) {
        GoodModel *model = [[GoodModel alloc]init];
        
        model.goodsNname = [dic objectForKey:@"goods_name"];
        model.imageUrl   = [dic objectForKey:@"image_url"];
        NSNumber*price   = [dic objectForKey:@"normal_price"];
        model.price =  [NSString stringWithFormat:@"%ld",(long)[price integerValue]];
//        model.price      = [[NSString stringWithFormat:@"%ld",(long)[price integerValue]] substringToIndex:2];
        //model.userCodel = [[[model.price dataUsingEncoding:NSUTF8StringEncoding] md5Hash] stringByAppendingPathExtension:@"codel"];
        model.userCodel = [[model.price dataUsingEncoding:NSUTF8StringEncoding]md5Hash];
        [arrayList addObject: model];
        [[DAOManager sharedInstanceDataDAO]saveArrayManager:model];
    }
    return arrayList;
}


@end
