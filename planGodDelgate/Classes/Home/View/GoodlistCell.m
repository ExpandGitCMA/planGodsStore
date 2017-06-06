//
//  GoodlistCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "GoodlistCell.h"
#import "UIImageView+AFNetworking.h"
@interface GoodlistCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;


@end

@implementation GoodlistCell

-(void)setGoodModel:(GoodModel *)model{
    _goodName.text = model.goodsNname;
    [_goodImage setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"4_Gods_pocket"]];
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
