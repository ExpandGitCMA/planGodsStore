//
//  DFCHotSearch.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/9.
//  Copyright © 2016年 DFC. All rights reserved.
//
#import "DFCHotSearch.h"
#import "HistoryViewCell.h"
#import "PlanConst.h"
#import "PlanColorDef.h"
@interface DFCHotSearch ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)id<DFCHotSearchDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *hotSearchView;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,copy) NSMutableArray *data;
@property (strong, nonatomic)UIView *searchline;
@property (nonatomic, strong)HistoryViewCell *cell;
@end

@implementation DFCHotSearch

+(DFCHotSearch*)initWithDFCHotSearchFrame:(CGRect)frame delegate:(id<DFCHotSearchDelegate>)delgate{
    DFCHotSearch *hotSearch = [[[NSBundle mainBundle] loadNibNamed:@"DFCHotSearch" owner:self options:nil] firstObject];
    hotSearch.frame = frame;
    hotSearch.delegate =delgate;
    return hotSearch;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
   _data = [NSMutableArray arrayWithArray:@[@"防螨夏被",@"小月饼",@"泰国进口",@"夏装t恤",@"灯具",@"品牌折扣",@"进口商品",@"芒果"]];
    
    UICollectionViewFlowLayout *fallLayout = [[UICollectionViewFlowLayout alloc]init];
    fallLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 130) collectionViewLayout:fallLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"HistoryViewCell" bundle:nil] forCellWithReuseIdentifier:@"HistoryViewCell"];
    [self.hotSearchView addSubview:_collectionView];
    
    
    _searchline = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height+10, SCREEN_WIDTH, 0.5)];
    _searchline.backgroundColor = UIColorFromRGB(SearchTypeColor);
    [self.hotSearchView addSubview:_searchline];

}

#pragma mark --定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryViewCell" forIndexPath:indexPath];
    cell.keyword = _data[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_cell == nil) {
        _cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryViewCell" owner:self options:nil] firstObject];
    }
    _cell.keyword = _data[indexPath.row];
    return [_cell sizeForCell];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark-点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *hotSearch = [_data objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(topHotSearch:hotSearchStr:)]) {
        [self.delegate topHotSearch:self hotSearchStr:hotSearch];
    }
    DEBUG_NSLog(@"hotSearch=%@",hotSearch);
}
@end
