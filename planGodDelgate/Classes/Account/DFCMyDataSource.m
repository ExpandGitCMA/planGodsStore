//
//  DFCMyDataSource.m
//  planGodDelgate
//
//  Created by ZeroSmell on 17/1/20.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "DFCMyDataSource.h"

@interface DFCMyDataSource ()
@property (nonatomic, strong) UIButton *customBtn;
@end

@implementation DFCMyDataSource

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBarItem];
}

-(void)initBarItem{
    self.title = @"我的资料";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(DefaulColor)}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back1"] style: UIBarButtonItemStylePlain target:self action:@selector(barDataback)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chat_bottom_up_nor"] style: UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
}

- (void)btnClick{
    
}

-(void)barDataback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
