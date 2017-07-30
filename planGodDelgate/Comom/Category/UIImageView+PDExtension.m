//
//  UIImageView+PDExtension.m
//  planByGodWin
//
//  Created by 童公放 on 2017/7/27.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "UIImageView+PDExtension.h"
#import "UIImage+MJ.h"
@implementation UIImageView (PDExtension)

- (void)setHeaderUrl:(NSString *)url
{
    [self setCircleHeaderUrl:url];
}

- (void)setCircleHeaderUrl:(NSString *)url
{
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"profile"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) return;
//        self.image = [image circleImage];
//    }];
}

- (void)setHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName
{
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) return;
//        self.image = [image circleImage];
//    }];
    
}


@end
