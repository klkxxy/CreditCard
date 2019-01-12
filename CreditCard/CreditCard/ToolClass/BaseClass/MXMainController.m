//
//  LNMainController.m
//  LilacNight
//
//  Created by LilacNight on 2018/8/4.
//  Copyright © 2018年 LilacNight. All rights reserved.


#import "MXMainController.h"
#import "AppDelegate.h"


#import "LNNavigationController.h"
#define LNTabbarVC    @"vc"
#define LNTabbarTitle @"title"
#define LNTabbarImage @"image"
#define LNTabbarSelectedImage @"selectedImage"
#define LNTabbarItemBadgeValue @"badgeValue"
#define LNTabBarCount 2
extern NSString *NTESCustomNotificationCountChanged;
typedef NS_ENUM(NSInteger,NTESMainTabType) {
    LNMaiTypeHome,
    LNMaiTypeVideo,
    LNMaiTypeMessage,
    LNMaiTypeMy,
};
@interface MXMainController ()
@property (nonatomic,assign) NSInteger SessionUnreadCount;
@property (nonatomic,assign) NSInteger systemUnreadCount;
@property (nonatomic,assign) NSInteger customSystemUnreadCount;
@property (nonatomic,copy)  NSDictionary *LicPartnerModDic;

@end

@implementation MXMainController

#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(NTESMainTabType)type{
    
    if (_LicPartnerModDic == nil)
    {
        _LicPartnerModDic = @{
                        @(LNMaiTypeHome)       : @{
                                LNTabbarVC           : @"MXHomePageController",
                                LNTabbarTitle        : @"首页",
                                LNTabbarImage        : @"cchm_homeNoClick",
                                LNTabbarSelectedImage: @"cchm_homeClick"
                                },
                        @(LNMaiTypeVideo)    : @{
                                LNTabbarVC           : @"MXMyViewController",
                                LNTabbarTitle        : @"我的",
                                LNTabbarImage        : @"cchm_MyNoClick",
                                LNTabbarSelectedImage: @"cchm_MyClick"
                                
                                }
                        };
        
    }
    return _LicPartnerModDic[@(type)];
}

+ (instancetype)ShareInstance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[MXMainController class]]) {
        return (MXMainController *)vc;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetChildsVC];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (NSArray*)tabbars{
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < LNTabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

- (void)SetChildsVC{
    
    [[UITabBar appearance] setBarTintColor:CCOL_BOTTONTAB_COLOR];
    [[UITabBar appearance] setBackgroundColor:CCOL_BOTTONTAB_COLOR];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item = [self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[LNTabbarVC];
        NSString *title  = item[LNTabbarTitle];
        NSString *imageName = item[LNTabbarImage];
        NSString *imageSelected = item[LNTabbarSelectedImage];
        UIImage *selectedImage = [UIImage imageNamed:imageSelected];
        UIImage *normalImage = [UIImage imageNamed:imageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:normalImage
                                               selectedImage:selectedImage];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[LNTabbarItemBadgeValue] integerValue];
        [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MX_BUTTON_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MX_BUTTON_Noselect_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        [vcArray addObject:nav];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
}

- (void)RefreshSessionBadge{
    UINavigationController *nav = self.viewControllers[LNMaiTypeMessage];
    nav.tabBarItem.badgeValue = self.SessionUnreadCount ? @(self.SessionUnreadCount).stringValue : nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


@end
