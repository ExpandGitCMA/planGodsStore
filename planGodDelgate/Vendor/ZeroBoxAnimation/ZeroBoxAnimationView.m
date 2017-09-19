//
//  ZeroBoxAnimationView.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/9/19.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "ZeroBoxAnimationView.h"
#import "PlanConst.h"
@interface ZeroBoxAnimationView ()

@property(nonatomic,strong)UIView *zeroAlertView;
@property(nonatomic,strong)UIView *zeroBlackView;

@end

@implementation ZeroBoxAnimationView

+ (instancetype)zeroBoxViewWithFrame:(CGRect)frame delegate:(id<ZeroBoxViewDelegate>)delegate{
    ZeroBoxAnimationView *zeroBoxView = [[self alloc] initWithFrame:frame];
    zeroBoxView.delegate = delegate;
    return zeroBoxView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self zeroBlackView];
        [self  zeroAlertView];
    }
    return self;
}

-(UIView*)zeroBlackView{
    if (!_zeroBlackView) {
       _zeroBlackView = [[UIView alloc]initWithFrame:([UIScreen mainScreen].bounds)];
       _zeroBlackView.backgroundColor = [UIColor colorWithRed:(0)/255.0f green:(0)/255.0f blue:(0)/255.0f alpha:(0.6)];
        [self addSubview:_zeroBlackView];
    }
    return _zeroBlackView;
}

-(UIView*)zeroAlertView{
    if (!_zeroAlertView) {
        _zeroAlertView = [[UIView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150)];
         _zeroAlertView.userInteractionEnabled = YES;
         _zeroAlertView.layer.cornerRadius = 14;
         _zeroAlertView.layer.masksToBounds=YES;
         _zeroAlertView.layer.borderColor = [UIColor grayColor].CGColor;
        _zeroAlertView.layer.borderWidth= 0;
         _zeroAlertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_zeroAlertView];
    }
    return _zeroBlackView;
}

-(void)setAnimationType:(ZeroBoxAnimationType)animationType{
      _animationType = animationType;
}


-(void)showWithController:(UIViewController *)viewController{
    [viewController.view addSubview:self];
    switch (_animationType) {
        case ZeroBoxAnimationTypeDefault:{
            self.zeroBlackView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.zeroBlackView.alpha = 1;
                _zeroAlertView.frame = CGRectMake(20, 75, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150);
            } completion:nil];
          
            
        }
            break;
        case ZeroBoxAnimationTypeCenter:{
            _zeroAlertView.frame = CGRectMake(20, 75, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150);
            _zeroAlertView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            _zeroAlertView.alpha = 0;
            self.zeroBlackView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.zeroBlackView.alpha = 1;
                _zeroAlertView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                _zeroAlertView.alpha = 1;
            } completion:nil];
            
        }
            break;
        case ZeroBoxAnimationTypeLine:{
            _zeroAlertView.frame = CGRectMake((SCREEN_WIDTH-40)*0.5, 75, 0, SCREEN_HEIGHT - 150);
            self.zeroBlackView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.zeroBlackView.alpha = 1;
                _zeroAlertView.frame = CGRectMake(20, 75, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    for (id obj in _zeroAlertView.subviews) {
                        if ([obj isKindOfClass:[UIButton class]]) {
                            UIButton *btn = (UIButton *)obj;
                            btn.alpha = 1;
                        }else if ([obj isKindOfClass:[UILabel class]]) {
                            UILabel *lable = (UILabel *)obj;
                            lable.alpha = 1;
                        }
                    }
                }];
            }];

        }
            break;
        default:
            break;
    }
}

-(void)disMiss{
    switch (_animationType) {
        case ZeroBoxAnimationTypeDefault:{
            [UIView animateWithDuration:0.5 animations:^{
                _zeroAlertView.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 150);
                self.zeroBlackView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];

        }
            break;
        case ZeroBoxAnimationTypeCenter:{
            [UIView animateWithDuration:0.4 animations:^{
                _zeroAlertView.transform = CGAffineTransformMakeScale(.2f, .2f);
                _zeroAlertView.alpha = 0;
                self.zeroBlackView.alpha = 0;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];

        }
            break;
        case ZeroBoxAnimationTypeLine:{
            [UIView animateWithDuration:0.5 animations:^{
                _zeroAlertView.frame = CGRectMake((SCREEN_WIDTH - 40)*0.5, 75, 0, SCREEN_HEIGHT - 150);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
            break;
        default:
            break;
    }
}


@end
