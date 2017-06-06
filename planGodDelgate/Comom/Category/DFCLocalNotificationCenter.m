//
//  DFCLocalNotificationCenter.m
//  planByGodWin
//
//  Created by DaFenQi on 16/11/30.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "DFCLocalNotificationCenter.h"
#import "AppDelegate.h"
@implementation DFCLocalNotificationCenter

+ (void)sendLocalNotification:(NSString *)title
                     subTitle:(NSString *)subTitle
                         body:(NSString *)body {
    // 1、创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    
    // 设置消息提醒的数目
    NSInteger count = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
    content.badge = [NSNumber numberWithInteger:count];
    
    // 2、设置声音
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    // 3、触发模式
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1f repeats:NO];
    
    // 4、设置UNNotificationRequest
    NSString *requestIdentifier = @"TestRequest";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    // 5、把通知加到UNUserNotificationCenter，到指定触发点会被触发
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"通知");
    }];
}

@end
