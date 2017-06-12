//
//  BannerView.m
//  BannerScrollView
//
//  Created by ZeroSmell on 16/7/14.
//  Copyright © 2016年 JY. All rights reserved.
//

#import "BannerView.h"
#import "PlanConst.h"
#import "PlanColorDef.h"
#import "DFCStatusUtility.h"
#import "UIImageView+AFNetworking.h"
@interface BannerView ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *arraySource;//banner数据源
@property(nonatomic,strong)UIScrollView   *bannerScrollView;
@property(nonatomic,strong)UIImageView    *bannerImageView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSTimeInterval autoScrollTime;//轮播时差
@property(nonatomic,assign) BOOL autoBanner;//是否自动轮播, 默认=YES

@end

@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource{
    if (self=[super initWithFrame:frame]) {
         _arraySource=arraySource;
        //默认开启滚动和设置时间
        _autoBanner=YES;
        _autoScrollTime =5.0f;
        [self setBackgroundColor:[UIColor whiteColor]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self bannerScrollView];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self pageControl];
                [self bannerImageView];
            });
        });
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(UIScrollView*)bannerScrollView{
    if (!_bannerScrollView) {
      _bannerScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-30)];
      _bannerScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*(_arraySource.count+2), 0);
      _bannerScrollView.delegate=self;
      _bannerScrollView.pagingEnabled = YES;//分页效果
      _bannerScrollView.showsVerticalScrollIndicator = NO;
      _bannerScrollView.showsHorizontalScrollIndicator =NO;
      _bannerScrollView.bounces=NO;
      [_bannerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
      [self addSubview:_bannerScrollView];
  
    }
    return _bannerScrollView;
}

-(UIImageView*)bannerImageView{
  if (!_bannerImageView) {
    for (int i=0; i<_arraySource.count+2; i++) {
        _bannerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height)];
        _bannerImageView.contentMode = UIViewContentModeScaleToFill;
        _bannerImageView.userInteractionEnabled=YES;
        //添加点击手势
        UITapGestureRecognizer *top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureAction:)];
        _bannerImageView.tag=i;
        [_bannerImageView addGestureRecognizer:top];
        //取出数组最后一张图片
        if (i==0) {
        NSString*url = _arraySource[_arraySource.count-1];
        [_bannerImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"goodImgUrl"]];
        //_bannerImageView.image=[UIImage imageNamed:_arraySource[_arraySource.count-1]];
        }
        //取出数组第一张图
        else if (i==(_arraySource.count+2-1)){
            NSString*url = _arraySource[0];
            [_bannerImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"goodImgUrl"]];
            //_bannerImageView.image=[UIImage imageNamed:_arraySource[0]];
        }
        else{
            NSString*url = _arraySource[i-1];
            [_bannerImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"goodImgUrl"]];
            //_bannerImageView.image=[UIImage imageNamed:_arraySource[i-1]];
        }
        [_bannerScrollView addSubview:_bannerImageView];
    }
    
      //开启定时器
      [self timerOn];
   }
    return _bannerImageView;
}

-(UIPageControl*)pageControl{
  if (!_pageControl) {
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _bannerScrollView.frame.size.height+5, _bannerScrollView.frame.size.width, 30)];
    //设置总页数
    _pageControl.numberOfPages=_arraySource.count;
    _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    //设置显示某页面
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = UIColorFromRGB(DefaulColor);
    [self addSubview:_pageControl];
  }
    return _pageControl;
}

#pragma mark-UIScrollView的代理方法
//用户准备拖拽的时候关闭,定时器
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self timerOff];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self timerOn];
    //获取当前的偏移量
    CGPoint current = _bannerScrollView.contentOffset;
    CGPoint offset = CGPointMake(current.x + SCREEN_WIDTH, 0);
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0 options:0 animations:^{
         [DFCStatusUtility hideActivityIndicator];
        //判断是否已经翻到最后
        if (offset.x == (_arraySource.count+2) * SCREEN_WIDTH){
            //将当前位置设置为原来的第一张图片
            [_bannerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        }
        //判断是否已经翻到最前
        if (current.x == 0){
            //将当前位置设置为原来的最后一张图片
            [_bannerScrollView setContentOffset:CGPointMake(_arraySource.count * SCREEN_WIDTH, 0)];
        }
    } completion:^(BOOL finished) {
    
    }];
    
  
}

//滑动任何偏移的改变都会触发该方法
//解决最后一张有延时的问题
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint current = _bannerScrollView.contentOffset;
    if (current.x == (_arraySource.count+1) * SCREEN_WIDTH){
        [_bannerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }
    //显示滑动点的位置
    _pageControl.currentPage= _bannerScrollView.contentOffset.x/SCREEN_WIDTH-1;
}

//开启定时器
-(void)timerOn{
    if (_autoScrollTime < 0.5 || !_autoBanner){
        return;
    }
    //通过定时器来实现定时滚动
    self.timer=[NSTimer scheduledTimerWithTimeInterval:_autoScrollTime target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}

//关闭定时器
-(void)timerOff{
    [self.timer invalidate];
    self.timer=nil;
    
}
#pragma mark-定时器实现的方法
- (void)changeOffset{
    //设置滚动偏移
    CGPoint current = _bannerScrollView.contentOffset;
    CGPoint offset = CGPointMake(current.x + SCREEN_WIDTH, 0);
    [_bannerScrollView setContentOffset:offset animated:YES];
    //设置为0时,pageControl.currentPage不会加1;
    if ( _pageControl.currentPage==(_arraySource.count-1)) {
        [UIView animateWithDuration:0.25 animations:^{
            _pageControl.currentPage = 0;
            //改变内容显示的位置瞬间改变
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            _pageControl.currentPage++;
        }];
    }

}

#pragma mark-手势
-(void)GestureAction:(UITapGestureRecognizer *)top{
    NSLog(@"tag:%ld",(long)top.view.tag);
}

-(void)removeTimer{
    if (!_timer)return;
    [_timer invalidate];
    _timer = nil;
}

@end
