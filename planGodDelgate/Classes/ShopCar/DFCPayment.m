//
//  DFCPayment.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCPayment.h"

@implementation DFCPayment
//将一个xib添加到另外一个xib上
// 假设你的自定义view名字为CustomView，你需要在CustomView.m中重写 `- (instancetype)initWithCoder:(NSCoder *)aDecoder` 方法，代码如下：
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
}

+(DFCPayment*)initWithDFCPaymentViewFrame:(CGRect)frame{
    DFCPayment *payment = [[[NSBundle mainBundle] loadNibNamed:@"DFCPayment" owner:self options:nil] firstObject];
    payment.frame = frame;
    return payment;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    _paytime.text =dateString;
    
}

@end
