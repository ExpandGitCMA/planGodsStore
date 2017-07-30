//
//  UIImageView+PDExtension.h
//  planByGodWin
//
//  Created by 童公放 on 2017/7/27.
//  Copyright © 2017年 DFC. All rights reserved.
// UIImageView切圆角导致内存增长较大

#import <UIKit/UIKit.h>

@interface UIImageView (PDExtension)
// 没有占位图片
- (void)setHeaderUrl:(NSString *)url;
// 带有占位图片
- (void)setHeaderUrl:(NSString *)url withplaceholderImageName:(NSString *)placeholderImageName;

@end
