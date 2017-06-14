//
//  PlanHomeVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "PlanHomeVC.h"
#import "PlanSearchVC.h"
#import "PlanColorDef.h"
#import "NetworkManager.h"
#import "GoodModel.h"
#import "GoodlistView.h"
#import "PlanAccountView.h"
#import "DAOManager.h"
#import "DFCStatusUtility.h"
#import "ShopCarCount.h"
#import "DFCShopCarVC.h"
#import "DFCShowMessage.h"
#import "DFCGodLaunchVC.h"
#import "DFCHotContent.h"
#import "NSUserDefaultsManager.h"
#import "DFCLocalNotificationCenter.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DFCMyDataSource.h"
#import "HomeDataSourceViewModel.h"
#import "NetworkLoading.h"
#import "NetworkStatusVC.h"
#import "GoodKFCModel.h"
#import "HistoryArchive.h"
#import "FileArchiveZip.h"
#import <objc/message.h>
#import "Person.h"
#import "NSViewCopy.h"
#import "NSDateComponentsObject.h"
#import "JSONKit.h"
#import "SQLDatabase.h"
#import "UserModel.h"
#import "User.h"
@interface PlanHomeVC ()<UIScrollViewDelegate,GoodlistDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,DFCAccountDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)HomeDataSourceViewModel *dataSourceViewModel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,weak)UISegmentedControl * control;
@property(nonatomic,strong)NSMutableArray*arraySource;
@property(nonatomic,strong)UILabel *count;
@property(nonatomic,strong)GoodlistView *goodView;
@property(nonatomic,strong)NSMutableArray *cacheSource;
@property(nonatomic,copy)NSArray *dictSource;
@property(nonatomic,strong)HistoryArchive *historyArchive;
@property(nonatomic,strong)FileArchiveZip *fileArchiveZip;
@property(nonatomic,copy)NSViewCopy *viewCopy;
@end
static const NSInteger page = 1;//标签数量
@implementation PlanHomeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLaunch:) name:@"pushLaunch" object:nil];
  
   [self refreshDataSource:page];
   [self initNavigationView];
    [self count];
    if ([self isExist]==YES) {
         [self.dataSourceViewModel downloadBannerUrl];
    }
    [[DAOManager sharedInstanceDataDAO]arrayManager];
    [[DAOManager sharedInstanceDataDAO]searcManager];
    [[DAOManager sharedInstanceDataDAO]shopCarManager];
    [self dictSource];

    [self.fileArchiveZip initWithPath];
    
    
}


-(NSArray*)dictSource{
    if (!_dictSource) {
        _dictSource = [GoodKFCModel parseWithDict:NULL];
        //DEBUG_NSLog(@"dictSource==%@",_dictSource);
    }
    return _dictSource;
}

-(HomeDataSourceViewModel*)dataSourceViewModel{
    if (!_dataSourceViewModel) {
        _dataSourceViewModel = [[HomeDataSourceViewModel alloc]init];
    }
    return _dataSourceViewModel;
}

- (NSString *)pathJsonFile {
    NSString *pathJsonFile = [[self pathCacheJsonFile] stringByAppendingPathComponent:@"json.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathJsonFile]) {
        [[NSFileManager defaultManager] createFileAtPath:pathJsonFile contents:nil attributes:nil];
    }
    return pathJsonFile;
}

-(void)refreshDataSource:(NSInteger)count{
    //判断一个给定路径是否为文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self pathCacheJsonFile]]) {[[NSFileManager defaultManager] createDirectoryAtPath:[self pathCacheJsonFile] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *page = [NSString stringWithFormat:@"%ld", (long)count];
    NSDictionary *dic = @{@"size":@"200", @"page":page};
    [[NetworkManager shareNetworkManager]getWithURL:urlGoods WithParmeters:dic compeletionWithBlock:^(id obj) {
        
        
        //直接创建文件夹写入pist文件
        NSString *filePath = [self pathJsonFile];
        NSDictionary *dict = obj[@"home_recommend_subjects"];
        BOOL isSuccess = [dict writeToFile:filePath atomically:YES];
        if (isSuccess) {
            NSLog(@"write success");
        } else {
            NSLog(@"write fail");
        }
        
        [self matchDataSource:obj[@"home_recommend_subjects"]];
        //归档
        [self.historyArchive saveDictionary:dict];
    } failed:^(NSError *error) {
        NSArray *obj = [NSArray arrayWithContentsOfFile:[self pathJsonFile]];
        [self matchDataSource:obj];
    }];
}



-(HistoryArchive*)historyArchive{
    if (!_historyArchive) {
        _historyArchive = [[HistoryArchive alloc]init];
    }
    return _historyArchive;
}

-(FileArchiveZip*)fileArchiveZip{
    if (!_fileArchiveZip) {
        _fileArchiveZip = [[FileArchiveZip alloc]init];
    }
    return _fileArchiveZip;
}


-(void)matchDataSource:(NSArray*)obj{
    NSMutableArray*list = [[NSMutableArray alloc] init];
    for (NSDictionary *dict  in obj) {
        [list addObjectsFromArray:[GoodModel parseWithJson:dict[@"goods_list"]]];
    }
    _arraySource = list;
    [self requests];
    [_goodView tableViewRefresh];
}

-(NSString*)pathCacheJsonFile{
    //获取指定沙盒目录
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docPath = [paths objectAtIndex:0];
//    NSString *cacheFolder = [docPath stringByAppendingPathComponent:JSONFILE];
  
   NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    return [cacheFolder stringByAppendingPathComponent:JSONFILE];
}

-(void)requests{
    _goodView = [[GoodlistView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) arraySource:_arraySource];
    _goodView.delegate = self;
    [self.scrollView addSubview:_goodView];
    PlanAccountView*account = [[PlanAccountView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    account.delegate = self;

    [self.scrollView addSubview:account];
}

-(void)didSelectRowAtIndexPath:(PlanAccountView *)didSelectRowAtIndexPath IndexPath:(NSInteger)IndexPath{
    switch (IndexPath) {
        case 0:{//我的资料
            DFCMyDataSource *dataSource = [[DFCMyDataSource alloc]init];
            [self.navigationController pushViewController:dataSource animated:YES];
        }break;
        case 5:{//拍照
            [self photoPiker];
        }break;
        case 9:{
            //[self toAdd];
            [self showActionSheet];
            //UIApplicationDidReceiveMemoryWarningNotification
            [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
            
        }break;
        default:
            break;
    }
    
}
-(void)showActionSheet{
    
    UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回到第3层",@"回到第一层",@"进入第5层", nil];
    
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"%ld",(long)buttonIndex);

}
-(void)toAdd{
    UIAlertController *alert = [[UIAlertController alloc]init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [alert addAction:archiveAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(BOOL)isExist{
    NSString *timer = [[NSUserDefaultsManager shareManager]getApresentTimer];
    DEBUG_NSLog(@"timer==%@",timer);
    if ([[self getNowaday] isEqualToString:timer]) {
        return NO;
    }else{
        [[NSUserDefaultsManager shareManager]setApresentTimer:[self getNowaday]];
        return YES;
    }
}

-(NSString*)getNowaday{
    NSDateFormatter *presentFormat  = [[NSDateFormatter alloc] init];
    [presentFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *nowaday = [presentFormat stringFromDate:[NSDate date]];
    return nowaday;
}


-(void)flashsale:(GoodlistView *)flashsale message:(NSInteger)message{
     DEBUG_NSLog(@"message=%ld",(long)message);
    DFCGodLaunchVC *godLaunchVC = [[DFCGodLaunchVC alloc]init];
    [self pushNextViewcontroller:godLaunchVC];
}

- (void)pushNextViewcontroller:(UIViewController *)vc{
    if ([[NetworkManager shareNetworkManager]networkStatus]==0) {
        NetworkStatusVC *noNetworkVC = [[NetworkStatusVC alloc] initWithNextVC:vc];
        [self.navigationController pushViewController:noNetworkVC animated:YES];
    } else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark-加入购物车操作
-(void)loadView:(GoodlistView *)loadView message:(NSString *)message{
    DEBUG_NSLog(@"message=%@",message);
    [self setShopCarCount:message];
     [DFCLocalNotificationCenter sendLocalNotification:@"加入购物车成功" subTitle:nil body:@"加入购物车"];
//    [[DFCShowMessage sharedView]showMessage:@"加入购物车成功" duration:2.0f];
}


-(void)btnFileFn:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0 options:0 animations:^{
       [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:(BOOL)nil];
    } completion:^(BOOL finished) {
        DEBUG_NSLog(@"当前选中分段是%ld",(long)index);
    }];
    
    
    //归档 NSDictionary*dict  = [self.historyArchive loadArchives];
   // DEBUG_NSLog(@"dict==%@",dict);
    //解压 [self.fileArchiveZip archiveZip];
    
}

-(void)newNavigationBar{
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"planBar.jpg"] forBarMetrics:  UIBarMetricsDefault];
   [super newNavigationBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _control.hidden = YES;
    _count.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    _control.hidden = NO;
    if ([[DAOManager sharedInstanceDataDAO]shopCarManager].count>0) {
       _count.hidden = NO;
      NSString *count = [NSString stringWithFormat: @"%ld", (unsigned long)[[DAOManager sharedInstanceDataDAO]shopCarManager].count];
      [self setShopCarCount:count];
    }
}

-(void)barMenu{
    DFCShopCarVC *shopCarVC = [[DFCShopCarVC alloc]init];
    [self.navigationController pushViewController:shopCarVC animated:NULL];
}

-(void)search{
    PlanSearchVC *searchVC = [[PlanSearchVC alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    //[self photoPiker];
      //[self readFolder];
}

-(NSMutableArray*)arraySource{
    if (!_arraySource) {
        _arraySource=[[NSMutableArray alloc]init];
    }
    return _arraySource;
}
-(NSMutableArray*)cacheSource{
    if (!_cacheSource) {
        _cacheSource=[[NSMutableArray alloc]init];
    }
    return _cacheSource;
}

-(void)initNavigationView{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_bag"] style: UIBarButtonItemStylePlain target:self action:@selector(barMenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_search_baritem"] style: UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    UISegmentedControl*control= [[UISegmentedControl alloc]initWithItems:@[@"首页",@"个人中心"]];
    control.frame = CGRectMake((SCREEN_WIDTH-170)/2, 25, 170, 30);
    control.tintColor = UIColorFromRGB(DefaulColor);
    control.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(btnFileFn:) forControlEvents: UIControlEventValueChanged];
     self.navigationItem.titleView = control;
    _control = control;
    [self scrollView];
}

-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
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

- (UILabel *)count{
    if (!_count){
        _count = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 15, 10)];
        _count.backgroundColor = UIColorFromRGB(DefaulColor);
        _count.textAlignment = NSTextAlignmentCenter;
        _count.textColor = [UIColor whiteColor];
        _count.layer.cornerRadius = 5.0f;
        _count.font = [UIFont systemFontOfSize:12];
        _count.layer.masksToBounds = YES;
        _count.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_count];
    }
    return _count;
}
-(void)setShopCarCount:(NSString*)count{
    _count.hidden = NO;
    //[self shakeView:self.view];
    _count.text = count;
}

/*
 *@加入购物车桌面抖动效果
 *@day 2016.12.8
 */
-(void)shakeView:(UIView*)viewToShake{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.5];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

-(void)pushLaunch:(NSNotification*)not{
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)photoPiker{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    //如果支持拍照就拍照否则从照片库选择照片
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
//        }UIImagePickerControllerSourceTypeSavedPhotosAlbum;//支持相片库
//    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//支持相片库
//    imagePicker.sourceType = sourcheType;
    
    //imagePicker.allowsEditing = YES;
    
    imagePicker.delegate = self;
    //4.随便给他一个转场动画
    imagePicker.modalTransitionStyle=  UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    NSURL *fileUrl = info[UIImagePickerControllerReferenceURL];
    UIImage*cacheImage = [PlanHomeVC compressImage:img targetSize:CGSizeMake(sourceImageCompressWidth, sourceImageCompressHeight)];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //判断一个给定路径是否为文件夹
        if (![[NSFileManager defaultManager] fileExistsAtPath:[self cacheFolder]]) {[[NSFileManager defaultManager] createDirectoryAtPath:[self cacheFolder] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *url = [fileUrl absoluteString];
        NSString *fileName = [[[url dataUsingEncoding:NSUTF8StringEncoding] md5Hash] stringByAppendingPathExtension:@"png"];
        NSString *cacheFile = [[self cacheFolder] stringByAppendingPathComponent:fileName];
        //将图片写入文件缓存
        [UIImageJPEGRepresentation(cacheImage, 0.6) writeToFile:cacheFile atomically:YES];
        DEBUG_NSLog(@"cacheFile==%@",[self cacheFolder]);
    }];
    
}


- (void)readFolder{
    NSString *path = [self cacheFolder];
    //创建一个新的NSFileManager*实例,每次调用返回一个不同的指针地址,保证线程安全
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *enumerator;
    enumerator = [fileManager enumeratorAtPath:path];
    while((path = [enumerator nextObject]) != nil) {
        if (![path isEqualToString:@".DS_Store"]) {
            [self.cacheSource addObject:path];
        }
    }
    DEBUG_NSLog(@"cacheSource=%@",_cacheSource);
    DEBUG_NSLog(@"cacheFile==%@",[self cacheFolder]);
}

-(NSString*)cacheFolder{
    //获取指定沙盒目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *cacheFolder = [docPath stringByAppendingPathComponent:IMAGECACHE_FOLDERNAME];
    return cacheFolder;
}

static NSUInteger const sourceImageCompressWidth = 800;
static NSUInteger const sourceImageCompressHeight = 600;
//图片压缩
+ (UIImage *)compressImage:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    if (width < targetWidth || height < targetHeight) {
        return sourceImage;
    }
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = width / targetWidth;
        CGFloat heightFactor = height / targetHeight;
        if(widthFactor > heightFactor){
            scaledWidth = width / heightFactor;
            scaledHeight = targetHeight;
        }
        else{
            scaledWidth = targetWidth;
            scaledHeight = height / widthFactor;
        }
        
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        DEBUG_NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    UIImage *smallImage = [UIImage imageWithData:UIImagePNGRepresentation(newImage)];
    return smallImage;
}

-(void)XXX{
    //将Dictionary转成Json
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *alert = [NSMutableDictionary dictionary];
    NSMutableDictionary *aps = [NSMutableDictionary dictionary];
    [alert setObject:@"a msg come!" forKey:@"body"];
    [aps setObject:alert forKey:@"alert"];
    [aps setObject:@"3" forKey:@"bage" ];
    [aps setObject:@"def.mp3" forKey:@"sound"];
    [jsonDic setObject:aps forKey:@"aps"];
    
    NSString *strJson = [jsonDic JSONString];
    NSLog(@"temp is :%@",strJson);
    
    
    //将json转成Dictionary
    NSData *data = [strJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *newDic = [data objectFromJSONData];
    NSLog(@"newDic= %@",newDic);
    
}
@end
