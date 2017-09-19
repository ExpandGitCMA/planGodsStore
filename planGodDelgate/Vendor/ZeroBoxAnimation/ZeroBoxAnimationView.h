//
//  ZeroBoxAnimationView.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/9/19.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,  ZeroBoxAnimationType) {
     ZeroBoxAnimationTypeDefault,
     ZeroBoxAnimationTypeCenter,
     ZeroBoxAnimationTypeLine,
};


@class ZeroBoxAnimationView;
@protocol ZeroBoxViewDelegate <NSObject>

@optional
- (void)didSelectToIndex:(ZeroBoxAnimationView *)didSelectToIndex
         toIndex:(NSInteger)index;

@end




@interface ZeroBoxAnimationView : UIView
/** 初始话（推荐使用） */
+ (instancetype)zeroBoxViewWithFrame:(CGRect)frame delegate:(id<ZeroBoxViewDelegate>)delegate ;
@property (nonatomic, weak) id<ZeroBoxViewDelegate> delegate;
/*动画效果类型,默认为Defaul*/
@property(nonatomic,assign) ZeroBoxAnimationType  animationType;
/*开启动画*/
-(void)showWithController:(UIViewController *)viewController;
/*关闭动画*/
-(void)disMiss;


@end
