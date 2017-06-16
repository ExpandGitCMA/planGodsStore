//
//  UIImage+Image.h
//  planGodDelgate
//   使用RunTime交换方法。
//  Created by ZeroSmile on 2017/6/16.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
// 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
// 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
//外部调用测试   UIImage *image = [UIImage imageNamed:@"123"];
@end
