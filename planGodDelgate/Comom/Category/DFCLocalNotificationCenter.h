//
//  DFCLocalNotificationCenter.h
//  planByGodWin
//
//  Created by DaFenQi on 16/11/30.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFCLocalNotificationCenter : NSObject

+ (void)sendLocalNotification:(NSString *)title
                     subTitle:(NSString *)subTitle
                         body:(NSString *)body;


@end
