//
//  DFCShowMessage.h
//  palnWinTearch
//
//  Created by ZeroSmell on 16/8/3.
//  Copyright © 2016年 JY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFCShowMessage : NSObject
+ (DFCShowMessage *)sharedView;
//提示框语句
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;

@end
