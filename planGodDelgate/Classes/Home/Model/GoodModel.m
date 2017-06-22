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

-(id)itemWithName:(NSString *)name{
    return name;
}

+(NSMutableArray<GoodModel *>*)parseWithJson:(NSArray *)list{
    NSMutableArray *arrayList = [[NSMutableArray alloc] init];
          GoodModel *model = [[GoodModel alloc]init];
    
    
    for (NSDictionary *dic in list) {
        GoodModel *model = [[GoodModel alloc]init];
        
        model.goodsNname = [dic objectForKey:@"goods_name"];
        model.imageUrl   = [dic objectForKey:@"image_url"];
        NSNumber*price   = [dic objectForKey:@"normal_price"];
        model.price =  [NSString stringWithFormat:@"%ld",(long)[price integerValue]];
        model.userCodel = [[model.price dataUsingEncoding:NSUTF8StringEncoding]md5Hash];
        [arrayList addObject: model];
        [[DAOManager sharedInstanceDataDAO]saveArrayManager:model];
        
      
    }
        [[DAOManager sharedInstanceDataDAO]saveArrayManager:model];
    return arrayList;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //找到和属性不一致名字的key，然后赋值给self的属性
    if ([key isEqualToString:@"description"]) {
        // self.descriptionStr = value; // 不推荐使用
        [self setValue:value forKey:@"descriptionStr"]; // 推荐
    }
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

#pragma mark --- 对于处理“类型”，就用下面的方法

// 处理特殊 ----（类型）例如：NSNumber--> NSString
- (void)setValue:(id)value forKey:(NSString *)key
{
    // price 服务器是 NSNumber
    // 服务器是 NSNumber ，模型表里是 NSString类型，所以，要处理
    if ([value isKindOfClass:[NSNumber class]]) {
        // NSNumber--> NSString
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}
@end
