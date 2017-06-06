//
//  DFCGodLaunchVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCGodLaunchVC.h"
#import "PlanColorDef.h"
#import "DFCHotContent.h"
#import "PlanConst.h"
#import "FlashGoods.h"
#import "NetworkManager.h"
#import "GoodModel.h"
#import "PlanConst.h"
#import "DFCStatusUtility.h"
@interface DFCGodLaunchVC ()<UIScrollViewDelegate,HotContentDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,copy)NSArray*hotArray;
@property(nonatomic,strong)DFCHotContent *hotContent;
@property(nonatomic,strong)FlashGoods *flashView;
@property(nonatomic,strong)NSMutableArray*arraySource;
@property(assign,nonatomic)NSInteger  isCurrentSelect;
@property(nonatomic,strong)NSMutableArray*arrayGoodsView;//标签复用view存储
@end

@implementation DFCGodLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self arraySource];
    [self arrayGoodsView];
    [self initNav];
    [self scrollView];
    [self hotArray];
    [self setContent];
}


-(void)setContent{
    _hotContent = [[DFCHotContent alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 46) HotSearch:_hotArray];
    _hotContent.delegate = self;
    [self refreshDataSource:_isCurrentSelect];
    [self.view addSubview:_hotContent];

}

-(void)selectStatus:(DFCHotContent *)selectStatus page:(NSInteger)page{
     [self refreshDataSource:page];
}

-(void)refreshDataSource:(NSInteger)count{
    if (![self isExist:count]) {
        FlashGoods*flashView = [[FlashGoods alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*count, 46,SCREEN_WIDTH, SCREEN_HEIGHT-46) count:count];
        //[flashView setBackgroundColor:[UIColor whiteColor]];
        flashView.tag = count;
        [_scrollView addSubview:flashView];
         //已创建视图保存数组(用于判断是否添加)
        [_arrayGoodsView addObject:flashView];
    }
    
    _flashView =  [self getFlashGoodsViewWithTag:count];
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0 options:0 animations:^{
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*count, 0) animated:nil];
    } completion:^(BOOL finished) {
    }];

}

-(BOOL)isExist:(NSInteger)index{
    if(_arrayGoodsView.count==0){
        return NO;
    }else{
        for (FlashGoods *flashGood in _arrayGoodsView) {
            if (flashGood.tag == index) {
                return YES;
            }
        }
        return NO;
    }
}

#pragma mark 通过tag值返回对应标签下的分类
-(FlashGoods*)getFlashGoodsViewWithTag:(NSInteger)tag{
    for (FlashGoods *flashGood in _arrayGoodsView) {
        if (flashGood.tag == tag) {
            return flashGood;
        }
    }
    return nil;
}

-(NSMutableArray*)arrayGoodsView{
    if (!_arrayGoodsView) {
        _arrayGoodsView=[[NSMutableArray alloc]init];
        
    }
    return _arrayGoodsView;
}
-(NSMutableArray*)arraySource{
    if (!_arraySource) {
        _arraySource=[[NSMutableArray alloc]init];
        
    }
    return _arraySource;
}
-(NSArray*)hotArray{
    if (!_hotArray) {
        _hotArray = @[@"衣橱换新",@"百货专场",@"御寒保暖",@"吃货集中"];
    }
    return _hotArray;
}
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.contentSize=CGSizeMake(self.view.frame.size.width*4, 0);
        _scrollView.delegate=self;
        _scrollView.pagingEnabled = YES;//分页效果
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator =NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.bounces=NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(void)initNav{
    self.title = @"限时抢购";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(DefaulColor)}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back1"] style: UIBarButtonItemStylePlain target:self action:@selector(pushback)];
}
-(void)pushback{
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
