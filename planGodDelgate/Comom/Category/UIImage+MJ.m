//
//  UIImage+MJ.m
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+MJ.h"
#import "PlanConst.h"
#define Image_Compress_Width    1200
#define Image_Compress_Height   900
#define Image_Compress_Quantity 0.8f

@implementation UIImage (MJ)

UIView *theNoNeedToDrawView;

#pragma mark 根据颜色获取图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

+ (UIImage *)compressImage:(UIImage *)sourceImage
                      xScale:(CGFloat)xScale
                      yScale:(CGFloat)yScale {
    CGSize targetSize = CGSizeMake(sourceImage.size.width * xScale, sourceImage.size.height * yScale);
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (!newImage) {
//        DEBUG_NSLog(@"compress image failed");
    }
    UIGraphicsEndImageContext();
    UIImage *smallImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, Image_Compress_Quantity)];
    return smallImage;
}

+ (UIImage *)compressImage:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = width / targetWidth;
        CGFloat heightFactor = height / targetHeight;
        if(widthFactor > heightFactor){
            scaledWidth = width / heightFactor;
            scaledHeight = targetHeight;
        }
        else{
            scaledWidth = targetWidth;
            scaledHeight = height / widthFactor;
        }

    }
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
//        DEBUG_NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    UIImage *smallImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, Image_Compress_Quantity)];
    return smallImage;
}

+ (UIImage *)roundedRectangleImageWithSize:(CGSize)aSize
                                 fillColor:(UIColor *)aFillColor
                              cornerRadius:(CGFloat)aRadius
{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, 0);
    
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, aSize.width, aSize.height) cornerRadius:aRadius];
    [aFillColor setFill];
    [roundedRectanglePath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)roundedRectangleImageWithSize:(CGSize)aSize
                                 fillColor:(UIColor *)aFillColor
                               borderColor:(UIColor *)aBorderColor
                               borderWidth:(CGFloat)aBorderWidth
                              cornerRadius:(CGFloat)aRadius
{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, 0);
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, aSize.width, aSize.height) cornerRadius:aRadius];
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(aBorderWidth, aBorderWidth, aSize.width - aBorderWidth * 2, aSize.height - aBorderWidth * 2) cornerRadius:aRadius - aBorderWidth];
    [aBorderColor setFill];
    [borderPath fill];
    [aFillColor setFill];
    [fillPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#define DegreesToRadians(degrees) (degrees) * M_PI / 180
CGFloat degreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat radiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:radiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)screenshot
{
    @autoreleasepool {
        CGSize imageSize = [[UIScreen mainScreen] bounds].size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
            if (![window respondsToSelector:@selector(screen)] ||
                [window screen] == [UIScreen mainScreen]) {
                CGContextSaveGState(context);
                
                CGContextTranslateCTM(context, [window center].x, [window center].y);
                
                CGContextConcatCTM(context, [window transform]);
                
                CGContextTranslateCTM(context,
                                      -[window bounds].size.width * [[window layer] anchorPoint].x,
                                      -[window bounds].size.height * [[window layer] anchorPoint].y);
                
                [[window layer] renderInContext:context];
                
                CGContextRestoreGState(context);
            }
        }
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();
        
        UIImage *smallSizeImage = [UIImage compressImage:image targetSize:CGSizeMake(Image_Compress_Width, Image_Compress_Height)];
        return smallSizeImage;
    }
}

+ (void)recursiveTraversalViews:(UIView *)superView renderAtContext:(CGContextRef)context {
    if (superView.subviews.count > 0) {
        for (UIView *view in superView.subviews) {
            if (view != nil) {
                if (view.tag == VIEW_NONEED_TODRAW_TAG) {
                    theNoNeedToDrawView = view;
                    //[[view layer] renderInContext:context];
                }
                [UIImage recursiveTraversalViews:view renderAtContext:context];
//                DEBUG_NSLog(@"%@", view);
            }
        }
    }
}

+ (UIImage *)draftPaperScreenShoot {
    @autoreleasepool {
        CGSize imageSize = [[UIScreen mainScreen] bounds].size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
              CGContextSaveGState(context);
            if (![window respondsToSelector:@selector(screen)] ||
                [window screen] == [UIScreen mainScreen]) {
                CGContextTranslateCTM(context, [window center].x, [window center].y);
                CGContextConcatCTM(context, [window transform]);
                CGContextTranslateCTM(context, -[window bounds].size.width * [[window layer] anchorPoint].x, -[window bounds].size.height * [[window layer] anchorPoint].y);
                [UIImage recursiveTraversalViews:window renderAtContext:context];
                theNoNeedToDrawView.hidden = YES;
                [[window layer] renderInContext:context];
                
                CGContextRestoreGState(context);
            }
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       theNoNeedToDrawView.hidden = NO;
        UIImage *smallSizeImage = [UIImage compressImage:image targetSize:CGSizeMake(Image_Compress_Width, Image_Compress_Height)];
        return smallSizeImage;
    }
}

+ (UIImage *)screenShoot:(UIView *)view {
    @autoreleasepool {
        CGSize imageSize = [view bounds].size;
        
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, [view center].x, [view center].y);
        CGContextConcatCTM(context, [view transform]);
        CGContextTranslateCTM(context, -[view bounds].size.width * [[view layer] anchorPoint].x, -[view bounds].size.height * [[view layer] anchorPoint].y);
        CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
        [[view layer] renderInContext:context];
        CGContextRestoreGState(context);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *smallSizeImage = [UIImage compressPngImage:image targetSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        view.layer.contents = (id)nil;
        
        return smallSizeImage;
    }
}

+ (UIImage *)screenShootForView:(UIView *)view {
    @autoreleasepool {
        CGSize imageSize = [view bounds].size;

//        if (SCREEN_WIDTH == isiPadePro_WIDTH) {
//            imageSize = [view bounds].size;
//        } else {
//            imageSize = CGSizeMake(1024, 768);
//        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, [view center].x, [view center].y);
        CGContextConcatCTM(context, [view transform]);
        CGContextTranslateCTM(context, -[view bounds].size.width * [[view layer] anchorPoint].x, -[view bounds].size.height * [[view layer] anchorPoint].y);
        CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
        [[view layer] renderInContext:context];
        CGContextRestoreGState(context);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        UIImage *smallSizeImage = [UIImage compressImage:image targetSize:CGSizeMake(Image_Compress_Width, Image_Compress_Height)];
        
        view.layer.contents = (id)nil;

        return smallSizeImage;
    }
}




+ (UIImage *)imageForView:(UIView *)view {
    @autoreleasepool {
        CGSize imageSize = [view bounds].size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, [view center].x, [view center].y);
        CGContextConcatCTM(context, [view transform]);
        CGContextTranslateCTM(context, -[view bounds].size.width * [[view layer] anchorPoint].x, -[view bounds].size.height * [[view layer] anchorPoint].y);
        CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);
        
        [[view layer] renderInContext:context];
        
        CGContextRestoreGState(context);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        view.layer.contents = (id)nil;
        
        return image;
    }
}

+ (UIImage *)compressPngImage:(UIImage *)sourceImage
                   targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = width / targetWidth;
        CGFloat heightFactor = height / targetHeight;
        if(widthFactor > heightFactor){
            scaledWidth = width / heightFactor;
            scaledHeight = targetHeight;
        }
        else{
            scaledWidth = targetWidth;
            scaledHeight = height / widthFactor;
        }
        
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        //        DEBUG_NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    UIImage *smallImage = [UIImage imageWithData:UIImagePNGRepresentation(newImage)];
    return smallImage;
}

+ (kImageType)typeForData:(NSData *)data {
    uint8_t cType;
    
    [data getBytes:&cType length:1];
    
    kImageType imageType;
    
    switch (cType) {
        case 0xFF:
            imageType = kImageTypeJpg;
            break;
        case 0x89:
            imageType = kImageTypePng;
            break;
        case 0x47:
            imageType = kImageTypeGif;
            break;
        case 0x49:
        case 0x4D:
            imageType = kImageTypeTiff;
            break;
        default:
            imageType = kImageTypeUnknow;
            break;
    }
    
    return imageType;
}



+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    [path addClip];
    [sourceImage drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImage:(NSString *)image
{
    return [[self imageNamed:image] circleImage];
}

-(UIImage*)cutImageRadius{
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
