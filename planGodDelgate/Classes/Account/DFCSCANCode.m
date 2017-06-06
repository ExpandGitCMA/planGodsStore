//
//  DFCSCANCode.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/12.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCSCANCode.h"
#import "PlanColorDef.h"
#import "PlanConst.h"
#import "DFCNewCode.h"
@interface DFCSCANCode ()

@property(nonatomic,strong)UIImageView*imageView;
@end

@implementation DFCSCANCode

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
   
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navItem];
    [self imageView];
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = @"http://www.baidu.com";//
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

-(void)barCode{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)navItem{
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back1"] style: UIBarButtonItemStylePlain target:self action:@selector(barCode)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_menu"] style: UIBarButtonItemStylePlain target:self action:@selector(scanCode)];
    self.title = @"我的二维码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(DefaulColor)}];

}

-(void)scanCode{

    DFCNewCode *newCode = [[DFCNewCode alloc]init];
    [self.navigationController pushViewController:newCode animated:YES];
    
}



/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


-(UIImageView*)imageView{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 64, 200, 200)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_imageView];
    return _imageView;
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
