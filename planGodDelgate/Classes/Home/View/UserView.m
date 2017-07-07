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

-(void)push {

    //查找字符串是否包含“心”
    NSString *str = @"每天都有好心情";
    if ([str containsString:@"心"]) {
        NSLog(@"字符串包含“心”");
        //containString适用于ios8系统，在ios7系统下会崩溃
    }
    NSRange range = [str rangeOfString:@"心"];
    if (range.location != NSNotFound) {//有@“心”
        //ios7系统下也适用
        NSLog(@"字符串包含“心”");
    }
    
//    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        DFCSendObjectModel *info = (DFCSendObjectModel *)evaluatedObject;
//        return [info.name containsString:textField.text];

}
-(void)pushViewController:(UIViewController*)controller {
    //获取最上层的控制器
    if (![[self viewController].navigationController.topViewController isKindOfClass:[controller class]]) {
        [[self viewController].navigationController pushViewController:controller animated:YES];
    }
}


@end
