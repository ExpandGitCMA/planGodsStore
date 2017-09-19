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
@property(nonatomic,strong)DFCHotContent *hotContent;
@property(nonatomic,weak)BannerCollection *collection;
@property(nonatomic,strong)NSMutableDictionary *params;
@end

static const  NSInteger  toHideRow;
@implementation GoodlistView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource{
    if (self = [super initWithFrame:frame]) {
        _arraySource = arraySource;
        [self initView];
        [self btnTop];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentOffset = CGPointMake(0, self.contentInset.top);
    _tableView.contentInset  = self.contentInset;
    _tableView.scrollIndicatorInsets = self.contentInset;
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
           // 如果是你需要隐藏的那一行，返回高度为0
            GoodModel*model = [_arraySource SafetyObjectAtIndex:indexPath.row];
            if (indexPath.row!=toHideRow) {
                tableViewHeight  =  [model.goodsNname sizeWithForRowHeight];
            }
        }
            break;
        default:
            break;
    }
    return  tableViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0|| section==1) {
        return 0;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self hotContent];
}

-(DFCHotContent*)hotContent{
    if (!_hotContent) {
        _hotContent = [[DFCHotContent alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 50) HotSearch:@[@"精选推荐",@"手机数码",@"运动健康",@"礼品鲜花",@"生活旅行",@"图书音像",@"家居生活"]];
        _hotContent.delegate = self;
    }
    return _hotContent;
}
-(void)selectStatus:(DFCHotContent*)selectStatus  page:(NSInteger)page{
    
    //采用字典缓存网络数据
   /*
    NSArray *dataSource = [[self params] objectForKey:[NSString stringWithFormat:@"%ld",(long)page]];
    if (dataSource.count) {
        _arraySource = dataSource;
         [_tableView reloadData];
    }else{
       [[self params] SafetySetObject:_arraySource forKey:[NSString stringWithFormat:@"%ld",(long)page]];
    }
    */
    
}

-(NSMutableDictionary*)params{
    if (!_params) {
        _params = [[NSMutableDictionary alloc]init];
    }
    return _params;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableCell;
    NSInteger  section= indexPath.section;
    switch (section) {
            case 0:{
                GoodBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCell"];
                tableCell = cell;
            } break;
            
            case 1:{
                GoodFlashsaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlashsaleCell"];
                [cell addTapGestureTarget:self action:@selector(goodTapGes:)];
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
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self scrollToTopAnimated:YES];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 49, 0);
}
- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.tableView.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self.tableView setContentOffset:off animated:animated];
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
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;{
    if ([scrollView isEqual:_tableView]) {
        _endScroll = scrollView.contentOffset.y;
    }else{
        _endScroll = scrollView.contentOffset.y;
    }
    //往上拉 并且 滚动视图超过一个屏幕
    /**************增加向上返回按钮动画效果**************/
    if(_startScroll - _endScroll>10 && _tableView.contentOffset.y>1000){
//        [UIView animateWithDuration:0.25 animations:^{
//           _btnTop.hidden = NO;
//        }];
        
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _btnTop.hidden = NO;
           _btnTop.frame = CGRectMake(self.frame.size.width-50, self.frame.size.height-50, 40.f, 40.f);
        } completion:nil];
        
        
    }else{
//        [UIView animateWithDuration:0.25 animations:^{
//            _btnTop.hidden = YES;
//        }];
        
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _btnTop.frame = CGRectMake(self.frame.size.width-50, self.frame.size.height, 40, 40);
        } completion:^(BOOL finished) {
            _btnTop.hidden = YES;
        }];
    }
    

    
}

/*
 当用户停止的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

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

-(void)tableViewRefresh{
    [_tableView reloadData];
}


-(void)dealloc{
      DEBUG_NSLog(@"走了");
}

@end
