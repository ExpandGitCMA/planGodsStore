//
//  ZYTextFieldSearch.m
//  JollyChic
//
//  Created by 杨才 on 15/12/21.
//  Copyright © 2015年 Lc. All rights reserved.
//

#import "ZYTextFieldSearch.h"
#import "PlanColorDef.h"
@interface ZYTextFieldSearch ()
@property (nonatomic,strong) UIImage *imgSearch;

@end

@implementation ZYTextFieldSearch

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _imgSearch = [UIImage imageNamed:@"img_search_icon"];
        UIImageView *imgViewSearch = [[UIImageView alloc] initWithImage:_imgSearch];
        self.leftView = (UIView *)imgViewSearch;
        //self.leftView.tintColor = [UIColor orangeColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;//文本框有文字显示清空
        self.layer.cornerRadius = 5 ;
        self.backgroundColor = UIColorFromRGB(EnFClassColore);
        self.returnKeyType = UIReturnKeySearch;
        self.font = [UIFont systemFontOfSize:14];
        self.borderStyle = UITextBorderStyleNone;
        self.placeholder = @"Search";
        self.tintColor = UIColorFromRGB(DefaulColor);
      
    }
    return self;
}

//控制搜索图片的位置，用到图片宽高
-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+8, (bounds.size.height - 12) *0.5 , _imgSearch.size.width, _imgSearch.size.height);
    return inset;
}

//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+29, bounds.origin.y, bounds.size.width -50, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+29, bounds.origin.y, bounds.size.width -50, bounds.size.height);
    
    return inset;
    
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );sssss
    CGRect inset = CGRectMake(bounds.origin.x +29, bounds.origin.y, bounds.size.width -50, bounds.size.height);
    return inset;
}

@end
