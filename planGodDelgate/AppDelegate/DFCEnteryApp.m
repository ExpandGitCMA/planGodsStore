//
//  DFCEnteryApp.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/19.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCEnteryApp.h"
#import "PlanHomeVC.h"
#import "DFCWelcomeVC.h"

@implementation DFCEnteryApp
+(void)switchToLoginViewController{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = nil;
 
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:[[PlanHomeVC alloc] init]];
    [nav.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [nav.tabBarController.tabBar setShadowImage:[UIImage new]];
    [[self class] showUI:nav];
}

+(void)switchNotFistViewController{
    AppDelegate *appDelegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = nil;
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:[[DFCWelcomeVC alloc] init]];
    [nav.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [nav.tabBarController.tabBar setShadowImage:[UIImage new]];
    [[self class] showUI:nav];
}

+ (void)switchToHomeViewController:(UIViewController*)controller{
    AppDelegate *appDelegate =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = nil;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [navi.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    //tabBackgd
    [navi.tabBarController.tabBar setShadowImage:[UIImage new]];
    [[self class] showUI:navi];
    
}

+ (void)showUI:(UINavigationController *)navi {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = navi;
    appDelegate.window.backgroundColor = [UIColor whiteColor];
    if (![appDelegate.window isKeyWindow]) {
        [appDelegate.window makeKeyAndVisible];
    }
}

@end
