//
//  MXAccount.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXAccount.h"

#define publicVariableTokenID @"publicVariableUserRequestToken_ID"
#define publicVariableUserPhone @"publicVariableUser_Phone"
#define publicVariableManufactorArr @"publicVariableManufactorArr"

@implementation MXAccount
singleton_implementation(MXAccount)

//  从沙河中获取个人信息
-(void)LoadTokenFromSandbox{
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    self.token = [publicVariabledefaults objectForKey:publicVariableTokenID];
    [publicVariabledefaults synchronize];
}

-(void)SaveTokenToSandbox{
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    [publicVariabledefaults setObject:self.token forKey:publicVariableTokenID];
    [publicVariabledefaults synchronize];
}

//保存用户id到沙盒
-(void)SaveUserPhoneToSandbox {
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    [publicVariabledefaults setObject:self.user_phone forKey:publicVariableUserPhone];
    [publicVariabledefaults synchronize];
}

-(void)LoadUserPhoneFromSandbox {
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    self.user_phone = [publicVariabledefaults objectForKey:publicVariableUserPhone];
}



@end
