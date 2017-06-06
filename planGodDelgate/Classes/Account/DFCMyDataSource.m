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
//    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _customBtn.frame = CGRectMake(0, 0, 40, 40);
//    //[_customBtn setTitle:@"➕" forState:UIControlStateNormal];
//    [_customBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
//    [_customBtn.imageView setBackgroundColor:UIColorFromRGB(DefaulColor)];
//    [_customBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_customBtn];
//    self.navigationItem.rightBarButtonItem = btn;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
