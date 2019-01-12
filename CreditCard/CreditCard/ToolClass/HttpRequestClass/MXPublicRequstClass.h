//
//  MXPublicRequstClass.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/16.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXPublicRequstClass : NSObject
typedef void(^SucessBlock)(id result);

+(void)uploadImg:(NSString *)filePath
         success:(SucessBlock)sucess;

+(void)LogoutReloadRequst;

+(void)getUserInfo;

@end
