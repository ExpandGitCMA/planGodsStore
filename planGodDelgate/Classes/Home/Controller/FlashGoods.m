//
//  FlashGoods.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/24.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "FlashGoods.h"
#import "GoodlistCell.h"
#import "GoodModel.h"
#import "PlanColorDef.h"
#import "NetworkManager.h"
#import "DFCStatusUtility.h"
#import "BannerView.h"
#import "DAOManager.h"
#import "DFCHotContent.h"
#import "DFCShowMessage.h"
@interface FlashGoods ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)  NSArray*arraySource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton*btnTop;
@property(nonatomic,assign)CGFloat startPosition;//每次滚动的最后
@property(nonatomic,assign)CGFloat startScroll; //开始拖拽y轴
@property(nonatomic,assign)CGFloat endScroll; //结束拖拽y轴
@property(nonatomic,assign)NSUInteger count;
@property(nonatomic,strong)UIImageView*flashsaleImage;
@property(nonatomic,strong)UIImage *imgFlashsale;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度所用字典
@end
@implementation FlashGoods
-(instancetype)initWithFrame:(CGRect)frame count:(NSUInteger)count{
    if (self = [super initWithFrame:frame]) {
     
        _count = count+1;
        [self initView];
        [self requst];
    }
    return self;
}


-(void)requst{
    NSString *page = [NSString stringWithFormat:@"%ld", (long)_count];
    NSDictionary *dic = @{@"size":@"50", @"page":page};
    [[NetworkManager shareNetworkManager]getWithURL:urlGoods WithParmeters:dic compeletionWithBlock:^(id obj) {
        _arraySource = [GoodModel parseWithJson:obj[@"goods_list"]];
        DEBUG_NSLog(@"滑动页面=%ld",(unsigned long)_count);
        [self flashsale];
        [_tableView reloadData];
    } failed:^(NSError *error) {
    
    }];
}
-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-46) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.contentOffset = CGPointMake(0, self.contentInset.top);
    _tableView.contentInset  = self.contentInset;
    _tableView.scrollIndicatorInsets = self.contentInset;
    [_tableView registerNib:[UINib nibWithNibName:@"GoodlistCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
    // 我们需要提高cell高度的计算效率，来节省时间。
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self addSubview:_tableView];
    [self setButTop];
}

//UITableView性能优化1
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return 100;
    }
    
}
- (NSMutableDictionary *)heightAtIndexPath
{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = @(cell.frame.size.height);
    
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    NSLog(@" 按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。");
//    
//    NSIndexPath *ip = [_tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
//    
//    NSIndexPath *cip = [[_tableView indexPathsForVisibleRows] firstObject];
//    
//    NSInteger skipCount = 8;
//    
//    if (labs(cip.row-ip.row) > skipCount) {
//        
//        NSArray *temp = [_tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.bounds.size.width, self.bounds.size.height)];
//        
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
//        
//        if (velocity.y<0) {
//            
//            NSIndexPath *indexPath = [temp lastObject];
//            if (indexPath.row+3<_arraySource.count) {
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
//            }
//            
//        } else {
//            
//            NSIndexPath *indexPath = [temp firstObject];
//            if (indexPath.row>3) {
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
//            }
//            
//        }
//        
//        //[self.needLoadArr addObjectsFromArray:arr];
//        DEBUG_NSLog(@"按需加载  %lu",(unsigned long)_arraySource.count);
//        
//    }
//    
//    
//}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 64, 0);
}


-(void)flashsale{
    _imgFlashsale= [UIImage imageNamed:[NSString stringWithFormat:@"%ld_Gods_pocket",(unsigned long)_count]];
    _flashsaleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _imgFlashsale.size.height/2)];
    _flashsaleImage.contentMode = UIViewContentModeScaleToFill;
    _flashsaleImage.image = _imgFlashsale;
    _tableView.tableHeaderView = _flashsaleImage;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arraySource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setGoodModel:model];
    return cell;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
//    CGSize titleSize=[model.goodsNname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
//    return 200+titleSize.height;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodModel *model = [_arraySource objectAtIndex:indexPath.row];
    [[DAOManager sharedInstanceDataDAO]shopCarManager:model];
    [[DFCShowMessage sharedView]showMessage:@"加入购物车成功" duration:2.0f];
    
}
-(void)setButTop{
    _btnTop = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnTop.frame =CGRectMake(self.frame.size.width-50, self.frame.size.height-110, 40, 40);
    [_btnTop setBackgroundImage:[UIImage imageNamed:@"btn_category_top"] forState:UIControlStateNormal];
    [_btnTop addTarget:self action:@selector(btnTopAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnTop.hidden=YES;
    [self addSubview:_btnTop];
}
#pragma mark-向上返回按钮
-(void)btnTopAction:(UIButton *)btn{
    _btnTop.hidden=YES;
    //[_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
     [self scrollToTopAnimated:YES];
}
- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.tableView.contentOffset;
    off.y = 0 - self.tableView.contentInset.top;
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
    if(_startScroll - _endScroll>10 && _tableView.contentOffset.y>1000){
//        _btnTop.hidden = NO;
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _btnTop.hidden = NO;
            _btnTop.frame = CGRectMake(self.frame.size.width-50, self.frame.size.height-110, 40.f, 40.f);
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

-(void)refresh{
    [_tableView reloadData];
}



@end
