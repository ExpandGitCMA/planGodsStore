//
//  DFCLabelRectForBounds.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/7/1.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "DFCLabelRectForBounds.h"

@implementation DFCLabelRectForBounds



-(void)transtAnimation{
//动画修改label上的文字
    // 方法一
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.75;
    [self.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.text = @"New";
    
    // 方法二
    [UIView transitionWithView:self
                      duration:0.25f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.text = @"Well done!";
                    } completion:nil];
    
    // 方法三
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.alpha = 0.0f;
                         self.text = @"newText";
                         self.alpha = 1.0f;
                     }];
}

-(void)drawRect:(CGRect)rect IntersRect:(CGRect)intersrect{
    //判断两个rect是否有交叉
    if (CGRectIntersectsRect(rect, intersrect)) {
    }
}


- (void)drawRectAttributedString:(UILabel*)label{
    //设置UILabel行间距
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:label.text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:20];
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, label.text.length)];
    label.attributedText = attrString;
    
    
   //UILabel显示不同颜色字体
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,6)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11,5)];
    label.attributedText = string;
    
    // 查看系统所有字体
    for (id familyName in [UIFont familyNames]) {
        NSLog(@"%@", familyName);
        for (id fontName in [UIFont fontNamesForFamilyName:familyName]) NSLog(@"  %@", fontName);
    }
    // 也可以进入这个网址查看 http://iosfonts.com/
}



// 重写label的textRectForBounds方法 让label的文字内容显示在左上／右上／左下／右下／中心顶／中心底部
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.textAlignment) {
        case  NSTextAlignmentLeft : {
            rect.origin = bounds.origin;
        }
            break;
        case  NSTextAlignmentRight: {
            rect.origin = CGPointMake(CGRectGetMaxX(bounds) - rect.size.width, bounds.origin.y);
        }
            break;
        case  NSTextAlignmentNatural: {
            rect.origin = CGPointMake(bounds.origin.x, CGRectGetMaxY(bounds) - rect.size.height);
        }
            break;
        case    NSTextAlignmentJustified: {
            rect.origin = CGPointMake(CGRectGetMaxX(bounds) - rect.size.width, CGRectGetMaxY(bounds) - rect.size.height);
        }
            break;
        case NSTextAlignmentCenter: {
            rect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) / 2, CGRectGetMaxY(bounds) - rect.origin.y);
        }
            break;
            default:
            break;
    }
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:textRect];
    
    //UILabel设置内边距
    // 边距，上左下右
    UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

//子类化UILabel，重写drawTextInRect方法
/*- (void)drawTextInRect:(CGRect)rect{
    CGContextRef c = UIGraphicsGetCurrentContext();
    // 设置描边宽度
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    // 描边颜色
    self.textColor = [UIColor redColor];
    [super drawTextInRect:rect];
    // 文本颜色
    self.textColor = [UIColor yellowColor];
    CGContextSetTextDrawingMode(c, kCGTextFill);
    [super drawTextInRect:rect];
}
 */
@end
