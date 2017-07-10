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
        //当UITextView/UITextField中没有文字时，禁用回车键
       self.enablesReturnKeyAutomatically = YES;
        // 设置某个键盘颜色 self.keyboardAppearance = UIKeyboardAppearanceAlert;
        // 设置工程中所有键盘颜色 [[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceAlert];
    }
    return self;
}
//UITextView中的文字添加阴影效果
- (void)setTextLayer:(UITextView *)textView color:(UIColor *)color
{
    CALayer *textLayer = ((CALayer *)[textView.layer.sublayers objectAtIndex:0]);
    textLayer.shadowColor = color.CGColor;
    textLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    textLayer.shadowOpacity = 1.0f;
    textLayer.shadowRadius = 1.0f;
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
//自动搜索功能，用户连续输入的时候不搜索，用户停止输入的时候自动搜索(我这里设置的是0.5s，可根据需求更改)
// 输入框文字改变的时候调用
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    // 先取消调用搜索方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchNewResult) object:nil];
    // 0.5秒后调用搜索方法
    [self performSelector:@selector(searchNewResult) withObject:nil afterDelay:0.5];
    
    // 方法一（推荐使用修改UISearchBar的占位文字颜色）
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}
@end
