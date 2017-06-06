//
//  PlanSearchVC.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "PlanSearchVC.h"
#import "ZYTextFieldSearch.h"
#import "PlanColorDef.h"
#import "DFCHotSearch.h"
#import "GoodlistCell.h"
#import "GoodModel.h"
#import "PlanConst.h"
#import "DAOManager.h"
@interface PlanSearchVC ()<UITextFieldDelegate,DFCHotSearchDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) ZYTextFieldSearch *textFieldSearch;//搜索框
@property (nonatomic,strong) UIButton *btnSearchCancel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*arraySource;
@end

@implementation PlanSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textFieldSearch = [[ZYTextFieldSearch alloc]initWithFrame:CGRectMake(15, 25, self.view.frame.size.width-100, 30)];
    _textFieldSearch.delegate = self;
  
    _btnSearchCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSearchCancel.frame = CGRectMake((self.view.frame.size.width-90), 25, 90, 30);
   [_btnSearchCancel setTitle:@"取消" forState:UIControlStateNormal];
    _btnSearchCancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btnSearchCancel addTarget:self action:@selector(showDeleteFn:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSearchCancel setTitleColor:UIColorFromRGB(DefaulColor) forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_textFieldSearch];
    [[UIApplication sharedApplication].keyWindow addSubview:_btnSearchCancel];
    
   
    
    DFCHotSearch *hotSearch = [DFCHotSearch initWithDFCHotSearchFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205) delegate:self];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodlistCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_tableView setSeparatorColor:UIColorFromRGB(DefaulColor)];//分割线
    _tableView.tableHeaderView = hotSearch;
    [self.view addSubview:_tableView];
    
    _arraySource = [[DAOManager sharedInstanceDataDAO]searcManager];
    [self tableViewReload];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodModel*model = [_arraySource objectAtIndex:indexPath.row];
    CGSize titleSize=[model.goodsNname sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return 200+titleSize.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       [_textFieldSearch resignFirstResponder];

}

-(void)topHotSearch:(DFCHotSearch *)topHotSearch hotSearchStr:(NSString *)hotSearchStr{
    [_textFieldSearch becomeFirstResponder];
    _textFieldSearch.text = hotSearchStr;
    
}

-(NSMutableArray*)arraySource{
    if (!_arraySource) {
        _arraySource=[[NSMutableArray alloc]init];
    }
    return _arraySource;
}

#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField{//清空
    [self clearDateSource];
    [_tableView reloadData];
    return YES;
}


-(void)clearDateSource{
   [[DAOManager sharedInstanceDataDAO]clearDataManager];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {//搜索
    [_textFieldSearch resignFirstResponder];
    [self clearDateSource];
    for ( GoodModel *model in [[DAOManager sharedInstanceDataDAO]arrayManager]) {
        if ([model.goodsNname rangeOfString:_textFieldSearch.text].location==NSNotFound) {
            //不存在相同字符串
        }else{
            //存在相同字符串
            [[DAOManager sharedInstanceDataDAO]saveSearcManager:model];
        }
    }
    _arraySource = [[DAOManager sharedInstanceDataDAO]searcManager];
    DEBUG_NSLog(@"arraySource==%@",_arraySource);
    [self tableViewReload];
    return YES;
}


-(void)tableViewReload{
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0 options:0 animations:^{
        [_tableView reloadData];
    } completion:^(BOOL finished) {
    }];
}

- (void)showDeleteFn:(UIButton *)sender{
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0 options:0 animations:^{
        [self.navigationController popViewControllerAnimated:YES];
    } completion:^(BOOL finished) {
    
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _textFieldSearch.hidden = YES;
    _btnSearchCancel.hidden = YES;
    [_textFieldSearch resignFirstResponder];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    _textFieldSearch.hidden = NO;
    _btnSearchCancel.hidden = NO;
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
