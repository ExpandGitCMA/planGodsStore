//
//  DFCShowMessage.m
//  palnWinTearch
//
//  Created by ZeroSmell on 16/8/3.
//  Copyright © 2016年 JY. All rights reserved.
//

#import "DFCShowMessage.h"
#import "PlanColorDef.h"
#import "PlanConst.h"
@implementation DFCShowMessage
+ (DFCShowMessage *)sharedView
{
    static DFCShowMessage *shareMessage = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch , ^{
        shareMessage = [[self alloc] init];
    });
    return shareMessage;
}


-(void)showMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
    CGSize LabelSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width)/2+20, SCREEN_HEIGHT/2, LabelSize.width+20, LabelSize.height+10);
    
    [UIView animateWithDuration:duration animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end
