//
//  ShopCarCount.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/12.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "ShopCarCount.h"
#import "PlanColorDef.h"
@interface ShopCarCount ()
@property (weak, nonatomic) IBOutlet UILabel *count;

@end

@implementation ShopCarCount
+(ShopCarCount*)initWithShopCarCountViewFrame:(CGRect)frame{
    ShopCarCount *shopCarView = [[[NSBundle mainBundle] loadNibNamed:@"ShopCarCount" owner:self options:nil] firstObject];
    shopCarView.frame = frame;
    return shopCarView;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    _count.backgroundColor = UIColorFromRGB(DefaulColor);
    _count.layer.cornerRadius = 8;
    
}

-(void)setShopCarCount:(NSInteger)count{
    _count.text = [NSString stringWithFormat: @"%ld", (long)count];
}


@end
