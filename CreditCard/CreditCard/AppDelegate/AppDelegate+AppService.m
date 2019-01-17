//
//  AppDelegate+AppService.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/16.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "AppDelegate+AppService.h"

#import "IQKeyboardManager.h"
#import "LNNavigationController.h"
#import "MXHomePageController.h"

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
    
    MXHomePageController * mainTab = [[MXHomePageController alloc] initWithNibName:nil bundle:nil];
    LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:mainTab];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;

}


@end
