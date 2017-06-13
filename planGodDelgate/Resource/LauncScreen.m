//
//  LauncScreen.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/13.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "LauncScreen.h"

@implementation LauncScreen

+(LauncScreen*)initWithLauncScreenViewFrame{
    LauncScreen * launcScreen =  [[[NSBundle mainBundle] loadNibNamed:@"LauncScreen" owner:self options:nil] firstObject];
    launcScreen.frame  =  [UIApplication sharedApplication].keyWindow.frame;
    return launcScreen;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}
- (void)setNeedsLayout{

}
- (void)layoutIfNeeded{

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
