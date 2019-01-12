//
//  MXPublicRequstClass.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/16.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXPublicRequstClass.h"
#import "AppDelegate+AppService.h"

@implementation MXPublicRequstClass

+(void)getUserInfo{
    [[MXAccount sharedMXAccount] LoadUserPhoneFromSandbox];
    NSString *user_phone = [MXAccount sharedMXAccount].user_phone;
    
    [[MXHttpManagerClass HttpRequstManager] PostURL:user_info params:@{@"user_phone":user_phone} isHearderparam:YES success:^(NSInteger code, id result) {
        [SVProgressHUD dismiss];
        
        if (code == 0) {
            
            // 清除消息
            [MXUserMessageTool clearMessgae];
            MXUserMessage *userMessage = [MXUserMessage mj_objectWithKeyValues:result[@"message"]];
            [MXUserMessageTool saveUserMessage:userMessage];
            
            [MXAccount sharedMXAccount].token = result[@"message"][@"token"];
            [[MXAccount sharedMXAccount] SaveTokenToSandbox];
            
            [MXAccount sharedMXAccount].user_phone = result[@"message"][@"user_phone"];
            [[MXAccount sharedMXAccount] SaveUserPhoneToSandbox];
            
        }else{
            [SVProgressHUD showImage:NULL_IMAGE status:@"参数错误"];
        }
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}


+(void)uploadImg:(NSString *)filePath success:(SucessBlock)sucess{
    [[MXHttpManagerClass HttpRequstManager] PostURL:getUpToken params:@{} isHearderparam:YES success:^(NSInteger code, id result) {
        [SVProgressHUD dismiss];

        if (code == 0) {
            
            NSDictionary *message = result[@"message"];
            NSString *token = message[@"upToken"];
            
            QNUploadManager *upManager = [[QNUploadManager alloc]init];
            [upManager putFile:filePath key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if(info.ok)
                {
                    NSLog(@"请求成功");
                    if (sucess) {
                        sucess(resp);
                    }
                }
                else{
                    NSLog(@"失败");
                    //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                }
//                NSLog(@"info ===== %@", info);
//                NSLog(@"resp ===== %@", resp);
            } option:nil];
            
            
            

        }else{
            [SVProgressHUD showImage:NULL_IMAGE status:@"参数错误"];
        }
        
    } fail:^(NSError *error) {

        NSLog(@"%@",error);
    }];
}

+ (void)LogoutReloadRequst {
    [MXAccount sharedMXAccount].token = nil;
    [[MXAccount sharedMXAccount] SaveTokenToSandbox];
    
    [MXAccount sharedMXAccount].user_phone = @"";
    [[MXAccount sharedMXAccount] SaveUserPhoneToSandbox];
    
    [MXUserMessageTool clearMessgae];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate initWindow];
}



@end
