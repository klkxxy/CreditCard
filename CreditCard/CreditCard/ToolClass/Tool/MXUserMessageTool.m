//
//  LNUserMessageTool.m
//  LilacNight
//
//  Created by LilacNight on 2018/8/18.
//  Copyright © 2018年 LilacNight. All rights reserved.

#import "MXUserMessageTool.h"
#define UserPassagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation MXUserMessageTool
+(MXUserMessage *)message{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:UserPassagePath];
}

+(void)clearMessgae{
    
    NSFileManager *fieManager = [NSFileManager defaultManager];
    BOOL isexist = [fieManager fileExistsAtPath:UserPassagePath];
    if (isexist) {
        [fieManager removeItemAtPath:UserPassagePath error:NULL];
    }
}
+(void)saveUserMessage:(MXUserMessage *)message{
    
    [NSKeyedArchiver archiveRootObject:message toFile:UserPassagePath];
}

@end
