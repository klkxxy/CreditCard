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
    
    MXMainController * mainTab = [[MXMainController alloc] initWithNibName:nil bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;

}


@end
