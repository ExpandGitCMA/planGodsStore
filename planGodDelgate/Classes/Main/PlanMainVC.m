//
//  PlanMainVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "PlanMainVC.h"

@interface PlanMainVC ()

@end

@implementation PlanMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self newNavigationBar];
    [self newNavigationBack];

    
}

-(void)newNavigationBack{
   self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_bag"] style: UIBarButtonItemStylePlain target:self action:@selector(barBack)];
    self.navigationItem.leftBarButtonItem.tintColor = UIColorFromRGB(DefaulColor);
}

-(void)newNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"planBar.jpg"] forBarMetrics: UIBarMetricsDefault];
    //隐藏下滑线
//    [self.navigationController.navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
   
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    // 设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"planBar.jpg"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
-(void)barBack{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
