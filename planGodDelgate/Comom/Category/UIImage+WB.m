//
//  UIImage+WB.m
//  WeiBo
//
//  Created by Rosepooh on 14-1-12.
//  Copyright (c) 2014年 classroomM. All rights reserved.
//

#import "UIImage+WB.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPVolumeView.h>

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@implementation UIImage (WB)

+ (UIImage *)imageWithNamed:(NSString *)name
{
    if (iOS7) {
        //是7.0的话拼接字符串返回图像
        NSString *changeName = [name stringByAppendingString:@"_os7"];
        //用拼接的字符串返回图像
        UIImage *image = [self imageNamed:changeName];
        
        //如果没有加_os7的图片，就使用默认的
        if (image == nil) {
            image = [self imageNamed:name];
        }
        
        return image;
    }else{
        //6.0的话不拼接直接返回
        return [self imageNamed:name];
    }
    
}

//返回一个可以任意拉伸的图片
+ (UIImage *)resizeWithNamed:(NSString *)name
{
    UIImage *image = [self imageWithNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.width * 0.5];
}

+ (UIImage *)resizedImage:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale
{
    UIImage *image = [self imageWithNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftScale topCapHeight:image.size.height * topScale];
}

+(UIImage *)imageWithName:(NSString *)name andWithScale:(CGFloat)scale
{
    return [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:name]) scale:scale];
}

- (UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//获取一个视频的第一帧图片
+(UIImage*)scalelSet:(NSString*)filepath{
    NSURL *url = [NSURL URLWithString:filepath];
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
    generate1.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 2);
    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
    return one;
}

//获取视频的时长
+ (NSInteger)getVideoTimeByUrlString:(NSString *)urlString {
    NSURL *videoUrl = [NSURL URLWithString:urlString];
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
    CMTime time = [avUrl duration];
    int seconds = ceil(time.value/time.timescale);
    return seconds;
}

//UIImage和base64互转
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



@end
