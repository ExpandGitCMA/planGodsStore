//
//  GoodlistView.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "GoodlistView.h"
#import "GoodlistCell.h"
#import "GoodModel.h"
#import "PlanColorDef.h"
#import "NetworkManager.h"
#import "DFCStatusUtility.h"
#import "BannerView.h"
#import "DAOManager.h"
#import "DFCHotContent.h"
#import "BannerModel.h"
#import "BannerCollection.h"
#import "Safety.h"
#import "GoodBannerCell.h"
#import "GoodFlashsaleCell.h"
#import "NSString+NSStringBlankString.h"

@interface GoodlistView ()<HotContentDelegate,UITableViewDelegate,UITableViewDataSource>{
    dispatch_source_t _timer;
}
@property(nonatomic,copy)NSArray *arraySource;
@property(nonatomic,copy)NSMutableArray *bannerSource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton*btnTop;
@property(nonatomic,weak)BannerView*banner;
@property(nonatomic,assign)CGFloat startPosition;//每次滚动的最后
@property(nonatomic,assign)CGFloat startScroll; //开始拖拽y轴
@property(nonatomic,assign)CGFloat endScroll; //结束拖拽y轴
@property(nonatomic,strong)UIImageView*flashsaleImage;
@property(nonatomic,strong)UIImage *imgFlashsale;
@property(nonatomic,strong)UIView*bannerHeader;
@property(nonatomic,strong)UILabel *timerLabel;
@property(nonatomic,copy)NSString*hourLabel;
@property(nonatomic,copy)NSString*minuteLabel;
@property(nonatomic,copy)NSString*secondLabel;
@property(nonatomic,weak)DFCHotContent *hotContent;
@property(nonatomic,weak)BannerCollection *collection;
@end

@implementation GoodlistView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource{
    if (self = [super initWithFrame:frame]) {
        _arraySource = arraySource;
        [self bannerSource];
        [self initView];
        //[self bannerViewSource];
        //[self bannerModelSource];
        [self btnTop];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodBannerCell" bundle:nil] forCellReuseIdentifier:@"BannerCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodFlashsaleCell" bundle:nil] forCellReuseIdentifier:@"FlashsaleCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodlistCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
    [self addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    switch (section) {
            case 0:
                  num = 1;
            break;
            
            case 1:
                  num = 1;
            break;
            
            case 2:
              num = _arraySource.count;
            break;
            
        default:
            break;
    }
     return num;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableCell;
    NSInteger  section= indexPath.section;
    switch (section) {
            case 0:{
                GoodBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCell"];
                tableCell = cell;
            }break;
            
            case 1:{
                GoodFlashsaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlashsaleCell"];
                [cell addTapGestureTarget:self action:@selector(goodTapGes:)];
//                __weak typeof(self) weakSelf = self;
//              cell.goodGesBlock = ^(NSInteger goodGes) {
//                  if ([ weakSelf.delegate respondsToSelector:@selector(flashsale:message:)]) {
//                      [ weakSelf.delegate flashsale:self message:goodGes];
//                   }
//
//              };
                //[cell setGoodGesBlock:^(NSInteger  goodGes){ }];
                 tableCell = cell;
                
            }break;
            case 2:{
                GoodlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                GoodModel*model = [_arraySource SafetyObjectAtIndex:indexPath.row];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell setGoodModel:model];
                
                tableCell = cell;
            }break;
        default:
            break;
    }
    
    return tableCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger  section= indexPath.section;
    CGFloat     tableViewHeight = 0.0;
    switch (section) {
            case 0:{
                tableViewHeight =  187;
            }break;
           
            case 1:{
                 _imgFlashsale = [UIImage imageNamed:@"img_home_default_flashsale"];
                tableViewHeight =  _imgFlashsale.size.height+20;
            }break;
            
            case 2:{
            
                GoodModel*model = [_arraySource SafetyObjectAtIndex:indexPath.row];
                
                tableViewHeight  =  [model.goodsNname sizeWithForRowHeight];

            }
            break;
        default:
            break;
    }
    
    return  tableViewHeight;

}



-(UIButton*)btnTop{
    _btnTop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnTop.frame =CGRectMake(self.frame.size.width-50, self.frame.size.height-50, 40, 40);
    [_btnTop setBackgroundImage:[UIImage imageNamed:@"btn_category_top"] forState:UIControlStateNormal];
    [_btnTop addTarget:self action:@selector(btnTopAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnTop.hidden=YES;
    [self addSubview:_btnTop];
    return _btnTop;
}
#pragma mark-向上返回按钮
-(void)btnTopAction:(UIButton *)btn{
    _btnTop.hidden=YES;
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始拖拽滑动的距离
    _startPosition = scrollView.contentOffset.y;
    if ([scrollView isEqual:_tableView]) {
        _startScroll = scrollView.contentOffset.y;
    }else{
        _startScroll = scrollView.contentOffset.y;
    }
    //[_collection removeTimer];
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;{
    if ([scrollView isEqual:_tableView]) {
        _endScroll = scrollView.contentOffset.y;
    }else{
        _endScroll = scrollView.contentOffset.y;
    }
    //往上拉 并且 滚动视图超过一个屏幕
    if(_startScroll - _endScroll>10 && _tableView.contentOffset.y>1000){
        _btnTop.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
           _hotContent.hidden = NO;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _btnTop.hidden = YES;
            _hotContent.hidden = YES;
        }];
    }

}

/*
 当用户停止的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   // [_collection addTimer];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger  section= indexPath.section;
    switch (section) {
//        case 1:{
//           GoodFlashsaleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            
//        }break;
            
            case 2:{
                GoodModel *model = [_arraySource objectAtIndex:indexPath.row];
                [[DAOManager sharedInstanceDataDAO]shopCarManager:model];
                NSString *count = [NSString stringWithFormat: @"%ld", (unsigned long)[[DAOManager sharedInstanceDataDAO]shopCarManager].count];
                if ([self.delegate respondsToSelector:@selector(loadView:message:)]) {
                    [self.delegate loadView:self message: count];
                }
                
            }break;
  
        default:
            break;
    }
}

-(void)goodTapGes:(UIGestureRecognizer *)sender {
    __weak typeof(self) weakSelf = self;
    if ( [ weakSelf.delegate  respondsToSelector:@selector(flashsale:message:)]&&weakSelf.delegate) {
         [ weakSelf.delegate flashsale:self message:sender.view.tag];
    }
}

-(NSMutableArray*)bannerSource{
    if (!_bannerSource) {
         _bannerSource = [[NSMutableArray alloc]init];
    }
    return _bannerSource;
}

-(void)tableViewRefresh{
    [_tableView reloadData];
}


-(void)dealloc{
      DEBUG_NSLog(@"走了");
}

@end
