//
//  DFCPayment.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFCPayment : UIView
+(DFCPayment*)initWithDFCPaymentViewFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UILabel *paymoney;
@property (weak, nonatomic) IBOutlet UILabel *paytime;

@end
