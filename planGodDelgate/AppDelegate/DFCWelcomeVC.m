//
//  DFCWelcomeVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/19.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCWelcomeVC.h"
#import "PlanConst.h"
#import "PlanColorDef.h"
#import "DFCEnteryApp.h"
#import "PlanHomeVC.h"
@interface DFCWelcomeVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView   *bannerScrollView;
@property(nonatomic,strong)UIImageView    *bannerImageView;
@property(nonatomic,strong)UIPageControl *pageControl;


@end

@implementation DFCWelcomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
   
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bannerScrollView];
    [self pageControl];
    
}

-(UIScrollView*)bannerScrollView{
    if (!_bannerScrollView) {
        _bannerScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bannerScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*3, 0);
        _bannerScrollView.delegate=self;
        _bannerScrollView.pagingEnabled = YES;//分页效果
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator =NO;
        _bannerScrollView.bounces=NO;
        for (int i=0; i<3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_bannerScrollView.frame.size.width*i, 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height)];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_planGod.png",i+1]];
            imageView.userInteractionEnabled=YES;
            //添加点击手势
            UITapGestureRecognizer *top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerImageGesture:)];
            imageView.tag=i;
            [imageView addGestureRecognizer:top];
            [_bannerScrollView addSubview:imageView];
        }
        [self.view addSubview:_bannerScrollView];
        
    }
    return _bannerScrollView;
}

-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,30,_bannerScrollView.frame.size.width, 30)];
        //设置总页数
        _pageControl.numberOfPages=3;
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        //设置显示某页面
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //显示滑动点的位置
    _pageControl.currentPage= _bannerScrollView.contentOffset.x/SCREEN_WIDTH;
}

-(void)bannerImageGesture:(UITapGestureRecognizer *)top{
    NSLog(@"tag:%ld",(long)top.view.tag);
    if (top.view.tag==2) {
        PlanHomeVC *homeVC = [[PlanHomeVC alloc]init];
        [DFCEnteryApp switchToHomeViewController:homeVC];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
