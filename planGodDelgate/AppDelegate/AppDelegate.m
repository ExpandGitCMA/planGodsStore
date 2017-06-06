//
//  AppDelegate.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "AppDelegate.h"
#import "PlanHomeVC.h"
#import "NetworkManager.h"
#import "PlanColorDef.h"
#import "DFCStatusUtility.h"
#import "NSUserDefaultsManager.h"
#import "DFCLaunchView.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate
-(void)applicationDidFinishLaunching:(UIApplication *)application{
    if ([[UIScreen screens] count]>1) {
        [self prepareScreen:[[UIScreen screens] lastObject]];
    }
}

-(void)prepareScreen:(UIScreen*)connectScreen{
      connectScreen.overscanCompensation  =   UIScreenOverscanCompensationInsetBounds;
    CGRect frame = connectScreen.bounds;
    UIWindow *window = [[UIWindow alloc]initWithFrame:frame];
    [window setScreen:connectScreen];
    //window.hidden = NO;
}

-(void)didNotCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnect:) name:UIScreenDidConnectNotification object:nil];
}
- (void)screenDidConnect:(NSNotification *)notification{
    [self prepareScreen:[notification object]];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
//    [self applicationDidFinishLaunching:application];
//    [self didNotCenter];
    [self p_initLocalNotification:application];
    [self applicationDidFinishLaunch];
    [self registerReachability];
    
    return YES;
}

-(void)didFinishLaunch{
    NSString *filePath = [[NSUserDefaultsManager shareManager]getfilePath];
    BOOL isExist = [[NSUserDefaultsManager shareManager]isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        DFCLaunchView *advertiseView = [[DFCLaunchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        advertiseView.filePath = filePath;
        advertiseView.backgroundColor = [UIColor whiteColor];
        [advertiseView show];
    }
    [[NSUserDefaultsManager shareManager]getAdvertisingImage];
}

-(void)applicationDidFinishLaunch{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isNotFist = [userDefaults boolForKey:@"isNotFist"];
    if (isNotFist) {
        [DFCEnteryApp switchToLoginViewController];
        [self didFinishLaunch];
    }else{
        //第一次启动
        [userDefaults setBool:YES forKey:@"isNotFist"];
        [userDefaults synchronize];
        [DFCEnteryApp switchNotFistViewController];
    }
    UINavigationBar *tabBar = [UINavigationBar appearance];
    tabBar.tintColor=UIColorFromRGB(DefaulColor);
}


- (void)registerReachability{
    //监测网络
    [[NetworkManager shareNetworkManager] networkReaching];
   
}
//是否支持转屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
}

/**
 add by 何米颖
 16-11-30
 本地通知
 */
- (void)p_initLocalNotification:(UIApplication*)application {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // iOS 10 特有
        // 1、创建一个 UNUserNotificationCenter
        UNUserNotificationCenter *requestCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        requestCenter.delegate = self;
        [requestCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                
                // 点击允许
                NSLog(@"注册成功");
                [requestCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@",settings);
                }];
                
            }else {
                // 点击不允许
                NSLog(@"注册失败");
            }
            
        }];
    } else if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        // iOS 8 ~iOS 10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    } else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

#pragma mark - 10以后通知
// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request;  // 收到推送的请求
    UNNotificationContent *content = request.content;       // 收到推送的消息内容
    NSNumber *badge = content.badge;                        // 推送消息的角标
    NSString *body = content.body;                          // 推送消息体
    UNNotificationSound *sound = content.sound;             // 推送消息的声音
    NSString *subString = content.subtitle;                 // 推送消息的副标题
    NSString *title = content.title;                        // 推送消息的标题
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        NSLog(@"iOS10 前台收到本地通知：");
         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    } else {
       

        // 判断为本地通知
        NSLog(@"iOS 10 收到本地通知：{\nbody:%@,\ntitle:%@,\nsubtitle:%@,\nbadge:%@,\nsound:%@,\nuserInfo:%@\n}",body,title,subString,badge,sound,userInfo);
    }
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    // 通知图标减少一
    [UIApplication sharedApplication].applicationIconBadgeNumber --;
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:");
        
    }
    else {
        // 判断为本地通知
   
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}

#pragma mark - 其他版本通知
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //通知的图标减少方法一：  单例  减少
    [UIApplication sharedApplication].applicationIconBadgeNumber --;
    //减少方法二：
    //    application.applicationIconBadgeNumber--;
    
    // 视图推送到
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
