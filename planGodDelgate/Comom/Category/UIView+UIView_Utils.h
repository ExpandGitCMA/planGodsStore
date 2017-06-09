//
//  UIView+UIView_Utils.h
//  ScenicComplaints
//
//  Created by 凌晨 on 12/26/13.
//  Copyright (c) 2013 凌晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)
/**
 *  Description
 *
 *  @return 返回x坐标值
 */
- (CGFloat)left;

/**
 *  设置x坐标值
 *
 *  @param x 坐标值
 */
- (void)setLeft:(CGFloat)x;

/**
 *  Description
 *
 *  @return 返回y坐标值
 */
- (CGFloat)top;

/**
 *  设置y坐标值
 *
 *  @param y y坐标值
 */
- (void)setTop:(CGFloat)y;

/**
 *  Description
 *
 *  @return 返回UIView的右侧边的x坐标值
 */
- (CGFloat)right;
/**
 *  设置右侧边的x坐标值
 *
 *  @param right 右侧边的坐标值
 */

- (void)setRight:(CGFloat)right;

/**
 *  Description
 *
 *  @return 返回UIView的底部的y坐标值
 */
- (CGFloat)bottom;
/**
 *  设置底部的y坐标值
 *
 *  @param bottom 底部的y值
 */

- (void)setBottom:(CGFloat)bottom;
/**
 *  Description
 *
 *  @return 返回中心点的x坐标值
 */
- (CGFloat)centerX;
/**
 *  设置中心点的x坐标值
 *
 *  @param centerX x坐标值
 */
- (void)setCenterX:(CGFloat)centerX;

/**
 *  Description
 *
 *  @return 返回中心点的y坐标值
 */
- (CGFloat)centerY;

/**
 *  设置中心点的y坐标值
 *
 *  @param centerY y坐标值
 */
- (void)setCenterY:(CGFloat)centerY;

/**
 *  Description
 *
 *  @return 返回宽度
 */
- (CGFloat)width;

/**
 *  Description
 *
 *  @param width 设置宽度
 */
- (void)setWidth:(CGFloat)width;
/**
 *  Description
 *
 *  @return 返回高度
 */
- (CGFloat)height;

/**
 *  Description
 *
 *  @param height 返回高度
 */
- (void)setHeight:(CGFloat)height;

/**
 *  Description
 *
 *  @return 返回view的原点
 */
- (CGPoint)origin;

/**
 *  设置view的原点
 *
 *  @param origin 原点
 */
- (void)setOrigin:(CGPoint)origin;

/**
 *  Description
 *
 *  @return 返回view的大小size
 */
- (CGSize)size;

/**
 *  设置view的大小size
 *
 *  @param size 大小
 */
- (void)setSize:(CGSize)size;

/**
 *  给view添加单击收拾
 *
 *  @param block 单击手势执行的block
 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/**
 *  给view添加长按手势
 *
 *  @param block 长按手势执行的block
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;
@end
