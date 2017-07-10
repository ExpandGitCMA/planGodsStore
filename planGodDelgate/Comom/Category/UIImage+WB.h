//
//  UIImage+WB.h
//  WeiBo
//
//  Created by Rosepooh on 14-1-12.
//  Copyright (c) 2014年 classroomM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WB)

/**
 *  返回对7.0和6.0之间适配的图片
 */
+ (UIImage *)imageWithNamed:(NSString *)name;

/**
 *  返回一个可以任意拉伸的图片
 */

+ (UIImage *)resizeWithNamed:(NSString *)name;

/**
 *  返回指定拉伸区域的图片
 */
+ (UIImage *)resizedImage:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale;

/**
 *  返回指定压缩系数的图片
 */
+ (UIImage *)imageWithName:(NSString *)name andWithScale:(CGFloat)scale;

/**
 *  返回指定压缩尺寸的图片
 */
- (UIImage*)scaleToSize:(CGSize)size;
-(UIImage *)resizeImage:(UIImage *)image;
@end
