//
//  DFCDeliAddress.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/13.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCDeliAddress.h"

@implementation DFCDeliAddress
+(DFCDeliAddress*)initWithDFCDeliAddressViewFrame:(CGRect)frame{
    DFCDeliAddress *address = [[[NSBundle mainBundle] loadNibNamed:@"DFCDeliAddress" owner:self options:nil] firstObject];
    address.frame = frame;
    return address;
}

@end
