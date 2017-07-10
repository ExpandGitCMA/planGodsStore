//
//  UITabBarController+WZBTabBarViewController.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/7/10.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "UITabBarController+WZBTabBarViewController.h"
//修改tabBar的frame
@implementation UITabBarController (WZBTabBarViewController)
- (void)viewWillLayoutSubviews {
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 100;
    tabFrame.origin.y = self.view.frame.size.height - 100;
    self.tabBar.frame = tabFrame;
}
@end
