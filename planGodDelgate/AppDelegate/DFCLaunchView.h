//
//  DFCLaunchView.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/20.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
@interface DFCLaunchView : UIView
/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;
@end
