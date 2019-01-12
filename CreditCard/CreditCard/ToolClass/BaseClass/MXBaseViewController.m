//
//  MXBaseViewController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/9.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXBaseViewController.h"

@interface MXBaseViewController ()

@end

@implementation MXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;       //从navigationBar下面开始计算一直到屏幕tabBar上部
    self.edgesForExtendedLayout = UIRectEdgeAll;        //从屏幕边缘计算（默认）
    self.edgesForExtendedLayout = UIRectEdgeTop;        //navigationBar下面开始计算一直到屏幕tabBar上部
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self PartnerUseThisSetNavigationGradientBackImage];
    [self BackBarButtonItemWithTitle:@"  "];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else
    {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (UIButton *)BackBarButtonItemWithTitle:(NSString *)title {
    
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
        UIImage *image = [UIImage imageNamed:@"注册页面返回icon"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:MX_BLACK_COLOR forState:0];
        //        if (![NSString isEmpty:title]) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, 60, 40)];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20,0, 0);
        //        }
        
        [button addTarget:self action:@selector(NavigationItemBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem =  item;
        return button;
        
    }else{
        self.tabBarController.tabBar.hidden = NO;
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.navigationItem.hidesBackButton = YES;
    
    return nil;
}

//添加BarButtonItem
- (UIButton *)barButtonItemName:(NSString *)name withImageName:(NSString *)imageName targer:(NSString *)targerName isRight:(BOOL)right
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50,50);
    if (![NSString isEmpty:name]) {
        [button setTitle:name forState:UIControlStateNormal];
        button.titleLabel.font = FONTSIZE(16);
        [button setTitleColor:MX_BLACK_COLOR forState:UIControlStateNormal];
    }
    if (![NSString isEmpty:imageName]) {
        [button setImage:[UIImage imageNamed:imageName]  forState:UIControlStateNormal];
        
    }
    if (![NSString isEmpty:targerName]) {
        SEL action = NSSelectorFromString(targerName);
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    if (right) {
        if (![NSString isEmpty:imageName] && [NSString isEmpty:name]) {
            button.imageEdgeInsets  = UIEdgeInsetsMake(0, 30, 0, 0);
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }else
    {
        if (![NSString isEmpty:imageName] && [NSString isEmpty:name]) {
            button.imageEdgeInsets  =  UIEdgeInsetsMake(0, -30, 0, 0);
        }
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return button;
}
- (void)NavigationItemBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PartnerUseThisSetNavigationGradientBackImage
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MX_BLACK_COLOR,NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    self.navigationController.navigationBar.translucent = NO;
    
//    self.navigationController.navigationBar.backgroundColor = MX_MAIN_COLOR;
    
    //用图片做导航栏
    UIImage *kpartChatImage = [UIImage imageNamed:@"导航栏"];
    [self.navigationController.navigationBar  setBackgroundImage:kpartChatImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//设置导航透明
- (void)SetNavigationClear
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}



@end
