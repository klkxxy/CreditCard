//
//  MXAccount.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXAccount.h"

#define publicVariableIsTimingPushID @"publicVariableIsTimingPush_ID"


@implementation MXAccount
singleton_implementation(MXAccount)

//  从沙河中获取个人信息
-(void)LoadIsTimingPushFromSandbox{
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    
    self.isTimingPush = [publicVariabledefaults boolForKey:publicVariableIsTimingPushID];
    [publicVariabledefaults synchronize];
}

-(void)SaveIsTimingPushToSandbox{
    NSUserDefaults *publicVariabledefaults = [NSUserDefaults standardUserDefaults];
    [publicVariabledefaults setBool:self.isTimingPush forKey:publicVariableIsTimingPushID];
    [publicVariabledefaults synchronize];
}


@end
