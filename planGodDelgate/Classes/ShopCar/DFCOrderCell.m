//
//  DFCOrderCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCOrderCell.h"
#import "UIImageView+AFNetworking.h"
@interface DFCOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end

@implementation DFCOrderCell

-(void)setGoodModel:(GoodModel *)model{
    _goodsName.text = model.goodsNname;
    _goodsPrice.text = [NSString stringWithFormat:@"%@%@",@"¥",model.price];
    
    [_goodsImg setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"goodImgUrl"]];
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
