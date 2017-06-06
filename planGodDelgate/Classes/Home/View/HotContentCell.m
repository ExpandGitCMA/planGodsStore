//
//  HotContentCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "HotContentCell.h"
#import "PlanColorDef.h"
@interface HotContentCell ()
@property(nonatomic,strong)UIView *viewSelect; //显示是否为选中状态
@end

@implementation HotContentCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB(DefaulColor);
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.textAlignment =  NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _viewSelect = [[UIView alloc] init];
        [self.contentView addSubview:_viewSelect];
        [self.contentView addSubview:_titleLabel];

    }
    return self;
}

-(void)setSelectCell:(BOOL)isSelect{
    if (isSelect) {
        _titleLabel.textColor = UIColorFromRGB(DefaulColor);
        _viewSelect.backgroundColor = UIColorFromRGB(DefaulColor);
        _viewSelect.hidden = NO;
    }else{
        _titleLabel.textColor = UIColorFromRGB(BgGrayColore);
        _viewSelect.hidden = YES;
    }
    
}

- (CGSize)sizeForCell:(NSString*)title{
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    CGSize titleSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    _titleLabel.frame=CGRectMake(5, 15, titleSize.width, titleSize.height);
    _viewSelect.frame=CGRectMake(5, titleSize.height+26, titleSize.width, 2);
    return CGSizeMake(titleSize.width, titleSize.height);
}

@end
