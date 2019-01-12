//
//  MXAuthController.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXAuthController.h"
#import "MXLoginController.h"
#import "MXRegisterController.h"
#import "MXAuthView.h"

@interface MXAuthController ()
@property (strong,nonatomic) MXAuthView *authView;
@end

@implementation MXAuthController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self SetNavigationClear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self PartnerUseThisSetNavigationGradientBackImage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    [self authView];
}

#pragma mark - 懒加载 -
-(MXAuthView *)authView{
    if (!_authView) {
        
        MXAuthView *view = [MXAuthView initMXAuthView];
        view.frame = CGRectMake(0,-KSafeAreaTopHeight, kScreenWidth, kScreenHeight-KSafeAreaBottonHeight+KSafeAreaTopHeight);
        view.navigationController = self.navigationController;
        _authView = view;
        
        [self.view addSubview:_authView];
    }
    return _authView;
}



@end
