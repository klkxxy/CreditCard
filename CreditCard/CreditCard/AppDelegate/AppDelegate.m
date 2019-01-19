//
//  AppDelegate.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/8.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindow];
    
    [self initKeyBoard];
    
    [self initMobClick];
    
    [self initUserNotificationCenter:application];
    
    return YES;
}


- (void)initUserNotificationCenter:(UIApplication *)application
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"推送注册成功");
            }
        }];
        [application registerForRemoteNotifications];
    }
    
}



@end
