//
//  NetworkLoading.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/7.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkLoading : UIView
@property (nonatomic, strong) UIImageView *imgViewLoading;
-(void)startLoading;
-(void)stopLoading;
@end
