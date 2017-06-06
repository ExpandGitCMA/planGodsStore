//
//  PlanAccountView.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "PlanAccountView.h"
#import "PlanColorDef.h"
#import "DFCAccountCell.h"
#import "PlanConst.h"
#import "UIView+Additions.h"
#import "DFCSCANCode.h"
#import "DFCOrderPayVC.h"
#import "PlanColorDef.h"
#import "NSString+IMAdditions.h"
@interface PlanAccountView ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationBarDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy)   NSArray*arraySource;
@end

@implementation PlanAccountView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _arraySource = @[@"我的资料",@"我的订单",@"我的二维码",@"成为认证用户",@"关注",@"拍照",@"我的活动",@"秒杀记录",@"意见反馈",@"缓存大小"];
        
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView=[[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView = [UIView new];
    [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
    [_tableView registerNib:[UINib nibWithNibName:@"DFCAccountCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self addSubview:_tableView];


    
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arraySource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFCAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell tableView:tableView cell:cell indexPath:indexPath arraySource:_arraySource];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:IndexPath:)]&&_delegate) {
        [self.delegate didSelectRowAtIndexPath:self IndexPath:indexPath.row];
    }
    
    switch (indexPath.row) {
        case 2:{
             DFCSCANCode *code = [[DFCSCANCode alloc]init];
             [self topViewController:code];
        }break;
        case 5:{//拍照
            
            
        }break;
        case 9:{
        }break;
        default:
            break;
    }
    
    [self Index:indexPath.row];
}

-(void)Index:(NSInteger)Index{

    
}

-(void)topViewController:(UIViewController*)controller{
    if (![[self viewController].navigationController.topViewController isKindOfClass:[controller class]]) {
        [[self viewController].navigationController pushViewController:controller animated:NO];
        
    }
}


@end
