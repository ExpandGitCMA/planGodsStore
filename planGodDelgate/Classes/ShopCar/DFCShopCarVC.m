//
//  DFCShopCarVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/12.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCShopCarVC.h"
#import "PlanColorDef.h"
#import "DFCHotSearch.h"
#import "GoodlistCell.h"
#import "GoodModel.h"
#import "PlanConst.h"
#import "DAOManager.h"
#import "DFCOrderPayVC.h"
#import "Safety.h"
#import "NSArray+NSArryisExist.h"
#import "NSString+NSStringBlankString.h"
#import "SQLDatabase.h"
#define shopWidth SCREEN_WIDTH/3
#define shopHeight 45

@interface DFCShopCarVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSMutableArray*arraySource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView* paymenView;
@property(nonatomic,strong)UIButton*payButton;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UIImageView* imgCar;
@property(nonatomic,strong)UIButton*shop;
@end

@implementation DFCShopCarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViewItem];
    _arraySource = [[DAOManager sharedInstanceDataDAO]shopCarManager];
    //[self isExist:[self.arraySource copy]]==YES
    if ([_arraySource isNSNulNSArray]) {
        [self paymenView];
        [self tableView];
    }else{
        [self imgCar];
        [self shop];
    }
    // Do any additional setup after loading the view.

}

-(UIButton*)shop{
    _shop = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-shopWidth)/2, (SCREEN_HEIGHT/2+shopHeight), shopWidth, shopHeight)];
    [_shop setTitle:@"去购物" forState:UIControlStateNormal];
    [_shop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _shop.titleLabel.font = [UIFont systemFontOfSize:16];
    _shop.backgroundColor = UIColorFromRGB(DefaulColor);
    [_shop addTarget:self action:@selector(barShopCar) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_shop];
    return _shop;
}

-(UIImageView*)imgCar{
    if (!_imgCar) {
        _imgCar = [[UIImageView alloc] init];
        //Resource.bundle/shoppingbag_empty Resource.bundle
        NSString *paths = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
       
        NSString*url = [NSString stringWithFormat:@"%@%@",paths,@"/shoppingbag_empty"];
        DEBUG_NSLog(@"url==%@",url);
        _imgCar.image = [[UIImage imageNamed:@"Resource.bundle/shoppingbag_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imgCar.tintColor = UIColorFromRGB(DefaulColor);
        _imgCar.frame = CGRectMake((self.view.frame.size.width-_imgCar.image.size.width)/2, 64, _imgCar.image.size.width, _imgCar.image.size.height);
        _imgCar.contentMode =  UIViewContentModeCenter;
        [self.view addSubview:_imgCar];
    }
    return _imgCar;
}

-(UIView*)paymenView{
    if (!_paymenView) {
        _paymenView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44-64, SCREEN_WIDTH, 44)];
        _paymenView.backgroundColor = [UIColor clearColor];
        [self payButton];
        [self price];
        [self.view addSubview:_paymenView];
    }
    return _paymenView;
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:
                      CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=UIColorFromRGB(EbebebColor);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"GoodlistCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(void)payment:(UIButton *)payment{
    DFCOrderPayVC *orderPay = [[DFCOrderPayVC alloc]initWithDataSource:_arraySource payment:_price.text];
    [self.navigationController pushViewController:orderPay animated:YES];
}
-(void)barShopCar{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)editCar{
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return _arraySource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setGoodModel:model];
    cell.price.hidden = NO;
    cell.price.text = [NSString stringWithFormat:@"%@%@",@"¥",model.price];
    return cell;
    
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
//    CGSize titleSize=[model.goodsNname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
//    return 200+titleSize.height;
    
    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
    return [model.goodsNname sizeWithForRowHeight];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark-进入编辑和删除模式的方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;//删除模式
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arraySource removeObjectAtIndex:indexPath.row];
        _price.text = [NSString stringWithFormat:@"%@%@",@"商品总价:¥",[self count:_arraySource]];
        if (_arraySource.count==0) {
            //_paymenView.hidden = YES;
            [self imgCar];
            [self shop];
            [tableView removeFromSuperview];
            [_paymenView removeFromSuperview];
        }
        [tableView reloadData];
    }
}

#pragma mark-定制删除按钮上面的文字的方法
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [NSString stringWithFormat:@"删除"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewItem{
    self.title = @"购物车";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(DefaulColor)}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back1"] style: UIBarButtonItemStylePlain target:self action:@selector(barShopCar)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_menu"] style: UIBarButtonItemStylePlain target:self action:@selector(editCar)];
}
-(NSMutableArray*)arraySource{
    if (!_arraySource) {
        _arraySource=[[NSMutableArray alloc]init];
    }
    return _arraySource;
}


-(UIButton*)payButton{
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(_paymenView.frame.size.width-105, 0, 105, _paymenView.frame.size.height);
    [_payButton setTitle:@"去结算" forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _payButton.backgroundColor = UIColorFromRGB(DefaulColor);
    [_payButton addTarget:self action:@selector(payment:) forControlEvents: UIControlEventTouchUpInside];
    [_paymenView addSubview:_payButton];
    return _payButton;
}

-(UILabel*)price{
    _price = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _paymenView.frame.size.width-105, _paymenView.frame.size.height)];
    _price.font=[UIFont systemFontOfSize:15];
    _price.textAlignment=NSTextAlignmentCenter;
    _price.text = [NSString stringWithFormat:@"%@%@",@"商品总价:¥",[self count:_arraySource]];
    [_paymenView addSubview:_price];
    return _price;
}

-(NSString*)count:(NSMutableArray*)arraySource{
    NSMutableArray*list = [[NSMutableArray alloc]init];
    for (GoodModel *model in arraySource) {
        if (model.price!=nil) {
            [list addObject:model.price];
        }
    }
    NSNumber *mums = [list valueForKeyPath:@"@sum.floatValue"];
    DEBUG_NSLog(@"sum=%@",mums);
    return [NSString stringWithFormat:@"%ld",(long)[mums integerValue]];
}




@end
