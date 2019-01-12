//
//  MXAccount.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXAccount : NSObject
singleton_interface(MXAccount)

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *user_phone;
@property (strong, nonatomic) NSArray *manufactorArr;

//保存token
-(void)SaveTokenToSandbox;
-(void)LoadTokenFromSandbox;

/**
 *  保存用户数据到沙盒
 */
-(void)SaveUserPhoneToSandbox;
-(void)LoadUserPhoneFromSandbox;




@end
