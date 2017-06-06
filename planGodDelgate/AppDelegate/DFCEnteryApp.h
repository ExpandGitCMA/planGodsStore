//
//  DFCEnteryApp.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/19.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DFCEnteryApp : NSObject
+ (void)switchToHomeViewController:(UIViewController*)controller;
+ (void)switchToLoginViewController;
+ (void)switchNotFistViewController;
@end
