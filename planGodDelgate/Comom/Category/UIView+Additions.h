//
//  UIView+Additions.h
//  IM_Expensive
//
//  Created by 蔡士章 on 15/10/29.
//  Copyright © 2015年 szcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIView (Additions)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
- (CGSize)size;
- (void)setSize:(CGSize)size;

- (UIViewController *)viewController;
- (id)ancestorOrSelfWithClass:(Class)cls;
- (void)addSubviews:(NSArray *)views;
@end
