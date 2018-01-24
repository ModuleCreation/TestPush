//
//  TPPush.m
//  testPush
//
//  Created by tangpeng on 2018/1/23.
//Copyright © 2018年 TPQuietBro. All rights reserved.
//

#import "TPPush.h"
#import "JPUSHService.h"
#import "UserNotifications/UserNotifications.h"

//JPush
#define JpushAppKey  @"7b0d510f8dd1e5ff2599a171"
#define JpushAppSecret  @"2022f595ef7105efbab75ce0"
#define JpushAppKey_IDC  @"10aeded1c0640ab6395a332b"

@interface TPPush()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>

@end
@implementation TPPush

#pragma mark - JPUSHRegisterDelegate
// iOS 10 Support，当收到通知的时候触发这个方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //下面这句代码在iOS 10以上的效果就是展示通知横幅
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
}


// iOS 10 Support，当点击通知的时候，触发这个方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(NSInteger))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //用户点击通知的时候进行处理,给属性赋值，交给外部处理
    self.userInfo = userInfo;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}



#pragma mark - JpushNetStatus
/**
 极光网络状态监听
 */
- (void)addJpushNetworkStateObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(NetworkDidSetup:) name:kJPFNetworkDidSetupNotification object:nil];
    [center addObserver:self selector:@selector(NetworkDidClose:) name:kJPFNetworkDidCloseNotification object:nil];
    [center addObserver:self selector:@selector(NetworkIsConnecting:) name:kJPFNetworkIsConnectingNotification object:nil];
    [center addObserver:self selector:@selector(NetworkDidRegister:) name:kJPFNetworkDidRegisterNotification object:nil];
    [center addObserver:self selector:@selector(NetworkFailedRegister:) name:kJPFNetworkFailedRegisterNotification object:nil];
    [center addObserver:self selector:@selector(NetworkDidLogin:) name:kJPFNetworkDidLoginNotification object:nil];
    [center addObserver:self selector:@selector(ServiceError:) name:kJPFServiceErrorNotification object:nil];
    
}
// 正在连接中
- (void)NetworkIsConnecting:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"正在连接中:%@ %@",noti.object,noti.userInfo);
#else
#endif
}

// 连接成功
- (void)NetworkDidSetup:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"连接成功:%@ %@",noti.object,noti.userInfo);
#else
#endif
}

// 关闭连接
- (void)NetworkDidClose:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"关闭连接:%@ %@",noti.object,noti.userInfo);
#else
#endif
}
// 注册成功
- (void)NetworkDidRegister:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"注册成功:%@ %@",noti.object,noti.userInfo);
#else
#endif
}

//注册失败
- (void)NetworkFailedRegister:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"注册失败:%@ %@",noti.object,noti.userInfo);
#else
#endif
}

// 登录成功
- (void)NetworkDidLogin:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"登录成功:%@ %@",noti.object,noti.userInfo);
#else
#endif
}

// 错误提示
- (void)ServiceError:(NSNotification *)noti
{
#if DEBUG
    NSLog(@"错误提示:%@ %@",noti.object,noti.userInfo);
#else
#endif
}
@end
