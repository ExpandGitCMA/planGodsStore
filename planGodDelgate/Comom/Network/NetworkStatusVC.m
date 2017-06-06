//
//  NetworkStatusVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/7.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NetworkStatusVC.h"
#import "PlanColorDef.h"
#import "PlanConst.h"
#import "UIView+Additions.h"
#import "NetworkManager.h"

@interface NetworkStatusVC ()
@property (nonatomic, strong) UIViewController *nextVC; //将要跳转的VC
@property (nonatomic, strong) UIView *viewLoadingBackground; //半透明加载背景
@property (nonatomic, strong) UIImageView *imgViewLoading; //加载框
@end

@implementation NetworkStatusVC
- (instancetype)initWithNextVC:(UIViewController *)nextVC
{
    if (self = [super init]) {
        _nextVC = nextVC;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back1"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemBackAction)];
    self.navigationItem.leftBarButtonItem.tintColor = UIColorFromRGB(DefaulColor);
    
    [self initViewNoNetwork];
    [self initViewLoading];
}
- (void)leftBarButtonItemBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initViewNoNetwork
{
    UIImage *img = [UIImage imageNamed:@"img_network_error_571x262"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CM(0, 175 + 64, img.size.width, img.size.height);
    imgView.centerX = self.view.centerX;
    
    UIButton *btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReload.frame = CGRectMake(0, 175 + 64 + img.size.height + 28, 91, 28);
    btnReload.centerX = self.view.centerX;
    btnReload.backgroundColor = UIColorFromRGB(0xc41230);
    //kuikUIColorFromRGB(0xc41230);
    [btnReload setTitle:@"Reloading" forState:UIControlStateNormal];
    [btnReload setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnReload.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnReload addTarget:self action:@selector(btnReloadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubviews:@[imgView, btnReload]];
}



- (void)initViewLoading{
    _viewLoadingBackground = [[UIView alloc] initWithFrame:CM(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _viewLoadingBackground.backgroundColor = [UIColor blackColor];
    _viewLoadingBackground.alpha = 0.5;
    [WINDOW addSubview:_viewLoadingBackground];
    _viewLoadingBackground.hidden = YES;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i <= 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img_network_reload%d_160x160", i]];
        [array addObject:image];
    }
    
    _imgViewLoading = [[UIImageView alloc] init];
    _imgViewLoading.contentMode = UIViewContentModeCenter;
    _imgViewLoading.animationImages = array;
    _imgViewLoading.animationDuration = array.count * 0.25;
    _imgViewLoading.center = WINDOW.center;
     _imgViewLoading.tintColor = UIColorFromRGB(DefaulColor);    
    [WINDOW addSubview:_imgViewLoading];
}

- (void)btnReloadAction:(UIButton *)btn{
    
    if (!([[NetworkManager shareNetworkManager]networkStatus]==0)) {
        //获取当前堆栈里的所有viewControllers
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [array removeLastObject];
        [array addObject:_nextVC];
        [self.navigationController setViewControllers:array animated:NO];
        
    } else {
        //加载网络状态
        _viewLoadingBackground.hidden = NO;
        [_imgViewLoading startAnimating];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _viewLoadingBackground.hidden = YES;
            [_imgViewLoading stopAnimating];
        });
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
