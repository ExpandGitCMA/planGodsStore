//
//  UIButton+ActionButton.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/9.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *button);

@interface UIButton (ActionButton)
@property (nonatomic,copy) ActionBlock actionBlock;
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock;  
@end
