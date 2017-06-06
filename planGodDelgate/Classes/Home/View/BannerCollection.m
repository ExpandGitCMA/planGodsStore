//
//  BannerCollection.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/2.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "BannerCollection.h"
#import "BannerCell.h"
#import "PlanColorDef.h"
#import "Safety.h"
static NSString *const ReuseIdent = @"cell";

@interface BannerCollection ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *arraySource;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation BannerCollection
-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSMutableArray *)arraySource{
    if (self=[super initWithFrame:frame]) {
        [self collectionView];
        [self pageControl];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
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
       NSMutableArray*data = [[NSMutableArray alloc]init];
        NSString *path = [self cacheFolder];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *enumerator;
        enumerator = [fileManager enumeratorAtPath:path];
            while((path = [enumerator nextObject]) != nil) {
                if (![path isEqualToString:@".DS_Store"]) {
                    NSString*url = [NSString stringWithFormat:@"%@%@%@",[self cacheFolder],@"/",path];
                    [data addObject:url];
                }
            }
        
        if (!([data count]==0)||data == nil) {
            _arraySource = [NSMutableArray arrayWithArray:data];
            [_arraySource addObject:data.firstObject];
            [_arraySource insertObject:data.lastObject atIndex:0];
            _pageControl.numberOfPages = data.count;

        }
    }
    return _arraySource;
}

-(UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
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
    return self.arraySource.count;
}

-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _collectionView.frame.size.height-30, _collectionView.frame.size.width, 30)];
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = UIColorFromRGB(DefaulColor);
        _pageControl.enabled = NO;
        [self addSubview:_pageControl];
        [self addTimer];
    }
    return _pageControl;
}

-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)nextpage{
    //设置滚动偏移
    //设置滚动偏移
    CGFloat  interval = _collectionView.contentOffset.x +([UIScreen  mainScreen].bounds.size.width);
    [self.collectionView setAutoresizesSubviews:YES];
    [self.collectionView setContentOffset: CGPointMake(interval, 0) animated:YES];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    NSInteger page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _pageControl.currentPage = (int) (scrollView.contentOffset.x/scrollView.bounds.size.width)%(_arraySource.count - 2);
    if (page == 0) {
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width *(_arraySource.count - 2), 0);
    }else if (page == _arraySource.count - 1){//滚动到右边
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
       
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
@end
