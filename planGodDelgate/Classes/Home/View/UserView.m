//
//  UserView.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/16.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "UserView.h"
#import "UIView+Additions.h"


@interface UserView ()
@property(nonatomic,strong)UIView*view ;

@end

@implementation UserView

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)requestHttp:(HttpSucceedBlock)completedBlock{
    NSDictionary *dic ;
    if (completedBlock) {
         completedBlock(false ,dic );
    }
    
}


-(void)pushViewController:(UIViewController*)controller {
    //获取最上层的控制器
    if (![[self viewController].navigationController.topViewController isKindOfClass:[controller class]]) {
        [[self viewController].navigationController pushViewController:controller animated:YES];
    }
    
    
}


@end
