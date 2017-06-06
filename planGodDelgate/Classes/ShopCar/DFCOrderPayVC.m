//
//  DFCOrderPayVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCOrderPayVC.h"
#import "PlanColorDef.h"
#import "GoodModel.h"
#import "GoodModel.h"
#import "PlanConst.h"
#import "DFCOrderCell.h"
#import "DFCDeliAddress.h"
#import "DFCPayment.h"
@interface DFCOrderPayVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSMutableArray*arraySource;
@property(nonatomic,copy)NSString*price;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation DFCOrderPayVC

-(instancetype)initWithDataSource:(NSMutableArray *)arraySource payment:(NSString *)price{
    if (self = [super init]) {
        _price=price;
        _arraySource =arraySource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromRGB(DefaulColor)}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back1"] style: UIBarButtonItemStylePlain target:self action:@selector(barOrderPay)];
    // Do any additional setup after loading the view.
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=UIColorFromRGB(EbebebColor);
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"DFCOrderCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
    DFCDeliAddress *address = [DFCDeliAddress initWithDFCDeliAddressViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
    _tableView.tableHeaderView = address;
    
    DFCPayment *payment = [DFCPayment initWithDFCPaymentViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
    _tableView.tableFooterView = payment;
    payment.paymoney.text = _price;
    [self.view addSubview:_tableView];

    UIButton*payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(0, SCREEN_HEIGHT-44-64, SCREEN_WIDTH, 44);
    [payButton setTitle:@"去付款" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    payButton.backgroundColor = UIColorFromRGB(DefaulColor);
    [payButton addTarget:self action:@selector(paymoney:) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:payButton];

   

    
}
-(void)paymoney:(UIButton *)payment{
    
    DEBUG_NSLog(@"付款");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return _arraySource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFCOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setGoodModel:model];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(void)barOrderPay{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
