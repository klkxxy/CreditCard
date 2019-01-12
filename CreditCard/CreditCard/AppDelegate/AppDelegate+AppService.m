//
//  AppDelegate+AppService.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/16.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "AppDelegate+AppService.h"

#import "IQKeyboardManager.h"
#import "MXMainController.h"
#import "MXAuthController.h"

#import "MXAuthController.h"

#import "LNNavigationController.h"

@implementation AppDelegate (AppService)

- (void)initKeyBoard{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

}

- (void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[MXAccount sharedMXAccount] LoadTokenFromSandbox];
    NSString *token = [MXAccount sharedMXAccount].token;
    
    if ([token length]) {
        [MXPublicRequstClass getUserInfo];
        
        
        MXMainController * mainTab = [[MXMainController alloc] initWithNibName:nil bundle:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
    }else{
        MXAuthController *authVC = [[MXAuthController alloc]init];
        LNNavigationController *nav = [[LNNavigationController alloc]initWithRootViewController: authVC];

        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }
}

@end
