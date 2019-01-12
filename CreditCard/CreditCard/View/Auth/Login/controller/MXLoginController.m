//
//  MXLoginController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/9.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXLoginController.h"
#import "MXLoginView.h"
#import "MXMainController.h"

@interface MXLoginController ()
@property (strong,nonatomic) MXLoginView *loginView;
@property (strong, nonatomic) NSMutableDictionary *dicParams;
@end

@implementation MXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loginView];
    
    self.title = @"登录多抓熊";
    
}

#pragma mark - 懒加载 -
-(MXLoginView *)loginView{
    if (!_loginView) {

        MXLoginView *view = [MXLoginView initMXLoginView];
        view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-KSafeAreaTopHeight-KSafeAreaBottonHeight);
        _loginView = view;
        __weak typeof(self) weakself = self;
        _loginView.accountBlock = ^(NSInteger btnTag) {
            [weakself loginBtnClickBlock:btnTag];
        };
        
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
    }
    [self initdicParams];
    return _dicParams;
}
- (void)initdicParams {
    _dicParams[@"user_phone"] = self.loginView.account_TF.text;
    _dicParams[@"user_password"] = self.loginView.psd_TF.text;
}

#pragma mark - 点击事件回调和网络请求 -
-(void)loginBtnClickBlock:(NSInteger)btnTag{
    switch (btnTag) {
        case 0:
            [self loginRequest];
            break;
            
        default:
            break;
    }
}

-(void)loginRequest{
    [SVProgressHUD show];
    
    [[MXHttpManagerClass HttpRequstManager] PostURL:user_login params:self.dicParams isHearderparam:YES success:^(NSInteger code, id result) {
        [SVProgressHUD dismiss];
        
        if (code == 0) {
            NSLog(@"%@",result);
            
            // 清除消息
            [MXUserMessageTool clearMessgae];
            MXUserMessage *userMessage = [MXUserMessage mj_objectWithKeyValues:result[@"message"]];
            [MXUserMessageTool saveUserMessage:userMessage];

            [MXAccount sharedMXAccount].token = result[@"message"][@"token"];
            [[MXAccount sharedMXAccount] SaveTokenToSandbox];
            
            [MXAccount sharedMXAccount].user_phone = result[@"message"][@"user_phone"];
            [[MXAccount sharedMXAccount] SaveUserPhoneToSandbox];
            
            [SVProgressHUD showImage:NULL_IMAGE status:@"登录成功"];
            MXMainController * mainTab = [[MXMainController alloc] initWithNibName:nil bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
            
            
        }else{
            [SVProgressHUD showImage:NULL_IMAGE status:@"账号密码错误"];
        }
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
}


@end
