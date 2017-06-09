//
//  UILabel+AlignLabel.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/9.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "UILabel+AlignLabel.h"

@implementation UILabel (AlignLabel)

-(CGSize)alignTopWithWidth:(CGFloat)width{
    CGSize size = [self sizeThatFits:(CGSize){width,MAXFLOAT}];
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
    return self.frame.size;
}
@end
