//
//  DFCStatusUtility.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/12.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCStatusUtility.h"

@implementation DFCStatusUtility

+ (void)showActivityIndicator{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = [self keyWindow].center;
    activityIndicator.bounds = CGRectMake(0, 0, 50, 50);
    [[self keyWindow] addSubview:activityIndicator];
    [activityIndicator startAnimating];
    activityIndicator.hidden = NO;
}

+ (void)hideActivityIndicator{
    UIView *window = [self keyWindow];
    [window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIActivityIndicatorView class]]) {
            [(UIActivityIndicatorView *)obj stopAnimating];
            obj.hidden = YES;
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
}


+(UIView*)keyWindow{
    __block UIWindow *keyWindow;
    NSMutableArray *windows = [[NSMutableArray alloc]initWithArray:[UIApplication sharedApplication].windows];
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
            keyWindow = window;
            *stop = YES;
        }
    }];
    UIView *window = [[keyWindow subviews] lastObject];
    return window;

}
@end
