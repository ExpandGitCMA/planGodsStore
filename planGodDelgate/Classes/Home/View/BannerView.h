//
//  BannerView.h
//  BannerScrollView
//
//  Created by ZeroSmell on 16/7/14.
//  Copyright © 2016年 JY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource;
-(void)timerOff;
-(void)timerOn;
@end
