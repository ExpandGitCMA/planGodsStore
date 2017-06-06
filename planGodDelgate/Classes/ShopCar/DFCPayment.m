//
//  DFCPayment.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCPayment.h"

@implementation DFCPayment
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
