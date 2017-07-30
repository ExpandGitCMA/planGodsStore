//
//  UIImage+MJ.h
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFCBoard;

typedef NS_ENUM(NSUInteger, kImageType) {
    kImageTypeJpg,
    kImageTypePng,
    kImageTypeGif,
    kImageTypeTiff,
    kImageTypeUnknow
};

#define VIEW_NONEED_TODRAW_TAG       1000000

@interface UIImage (MJ)

+ (UIImage *)compressImage:(UIImage *)sourceImage
                targetSize:(CGSize)size;
+ (UIImage *)compressPngImage:(UIImage *)sourceImage
                   targetSize:(CGSize)size;

#pragma mark 根据颜色获取图片
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

+ (UIImage *)roundedRectangleImageWithSize:(CGSize)aSize
                                    fillColor:(UIColor *)aFillColor
                                 cornerRadius:(CGFloat)aRadius;

+ (UIImage *)roundedRectangleImageWithSize:(CGSize)aSize
                                    fillColor:(UIColor *)aFillColor
                                  borderColor:(UIColor *)aBorderColor
                                  borderWidth:(CGFloat)aBorderWidth
                                 cornerRadius:(CGFloat)aRadius;

+ (UIImage *)screenshot;            // 普通截屏
+ (UIImage *)draftPaperScreenShoot; // 草稿纸截屏
+ (UIImage *)screenShootForView:(UIView *)view; // 截屏某些视图
+ (UIImage *)screenShoot:(UIView *)view;
+ (UIImage *)easyScreenShootForView:(UIView *)view;
+ (UIImage *)noPrejudiceScreenShootForView:(UIView *)view;
+ (UIImage *)screenShootForBoard:(DFCBoard *)board;

+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

+ (kImageType)typeForData:(NSData *)data;
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;// 生成二维码图片

-(UIImage*)cutImageRadius;
- (instancetype)circleImage;
+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

@end
