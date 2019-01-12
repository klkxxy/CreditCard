//
//  MXRegisterController.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXRegisterController.h"
#import "MXRegisterView.h"

#import "MXRegUserinfoController.h"

@interface MXRegisterController ()
@property (strong,nonatomic) MXRegisterView *registerView;
@property (strong, nonatomic) NSMutableDictionary *dicParams;
@end

@implementation MXRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册多抓熊";
    
    [self registerView];
}

#pragma mark - 懒加载 -
-(MXRegisterView *)registerView{
    if (!_registerView) {
        
        MXRegisterView *view = [MXRegisterView initMXRegisterView];
        view.frame = CGRectMake(0,-KSafeAreaTopHeight, kScreenWidth, kScreenHeight-KSafeAreaBottonHeight+KSafeAreaTopHeight);
        _registerView = view;
        __weak typeof(self) weakself = self;
        _registerView.regBlock = ^{
            [weakself regRequest];
        };
        
        [self.view addSubview:_registerView];
    }
    return _registerView;
}


- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
    }
    [self initdicParams];
    return _dicParams;
}
- (void)initdicParams {
    _dicParams[@"user_phone"] = self.registerView.phone_TF.text;
    _dicParams[@"user_password"] = self.registerView.password_TF.text;
}

#pragma mark - 网络请求 -
-(void)regRequest{
    [SVProgressHUD showWithStatus:@"正在检测手机号。。。"];

    [[MXHttpManagerClass HttpRequstManager] PostURL:user_signup params:self.dicParams isHearderparam:YES success:^(NSInteger code, id result) {
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

            [SVProgressHUD showImage:NULL_IMAGE status:@"注册成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showImage:NULL_IMAGE status:@"检测成功"];
            });

            MXRegUserinfoController *reginfoVC = [[MXRegUserinfoController alloc]init];
            [self.navigationController pushViewController:reginfoVC animated:YES];

        }else{
            [SVProgressHUD showImage:NULL_IMAGE status:result[@"message"]];
        }

    } fail:^(NSError *error) {

        NSLog(@"%@",error);
    }];

    
    
}


@end
