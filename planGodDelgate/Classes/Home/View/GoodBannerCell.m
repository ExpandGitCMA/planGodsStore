//
//  GoodBannerCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "GoodBannerCell.h"
#import "BannerCell.h"
#import "PlanColorDef.h"
#import "Safety.h"
#import "PlanConst.h"
static NSString *const ReuseIdent = @"cell";
static NSUInteger  const SGMaxSections = 100;

@interface GoodBannerCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *arraySource;
@property (nonatomic,weak) NSTimer *timer;
@end

@implementation GoodBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self collectionView];
    [self pageControl];
}

-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, self.frame.size.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"BannerCell"  bundle:nil] forCellWithReuseIdentifier:ReuseIdent];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BannerCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdent forIndexPath:indexPath];
    NSString*url =  [_arraySource SafetyObjectAtIndex:indexPath.row];
    cell.banner.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",url]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.arraySource.count){
         return 1;
    }
    return self.arraySource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return SGMaxSections;
}

-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
//        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
         _pageControl.numberOfPages=self.arraySource.count;
        _pageControl.currentPage = 0;
//        _pageControl.currentPageIndicatorTintColor = UIColorFromRGB(DefaulColor);
        _pageControl.enabled = NO;
        
//        _pageControl.currentPageIndicatorTintColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_home_banner_select"]];
//        
//        _pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img_home_banner_unselect"]];
        
        [_pageControl  setValue:[UIImage imageNamed:@"img_home_banner_select"] forKeyPath:@"currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"img_home_banner_unselect"] forKeyPath:@"pageImage"];
        
        [self addSubview:_pageControl];
        [self addTimer];
    }
    return _pageControl;
}

-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(nextpages) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)nextpages{
    if (_arraySource.count == 0) return;
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
   
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:SGMaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == _arraySource.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = (int) (scrollView.contentOffset.x/scrollView.bounds.size.width)%(_arraySource.count );
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}


-(NSString*)cacheFolder{
    //获取指定沙盒目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *cacheFolder = [docPath stringByAppendingPathComponent:IMAGECACHE_FOLDERNAME_CACHE];
    return cacheFolder;
}


-(NSMutableArray*)arraySource{
    if (!_arraySource) {
       _arraySource = [[NSMutableArray alloc]init];
        NSString *path = [self cacheFolder];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *enumerator;
        enumerator = [fileManager enumeratorAtPath:path];
        while((path = [enumerator nextObject]) != nil&&![path isEqualToString:@".DS_Store"]) {
            NSString*url = [NSString stringWithFormat:@"%@%@%@",[self cacheFolder],@"/",path];
            [_arraySource addObject:url];
        }
    }
    return _arraySource;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self defaultSelectedScetion];
}

/// 默认选中的组
- (void)defaultSelectedScetion {
    if (self.arraySource.count == 0) return;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:SGMaxSections / 2] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self removeTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
