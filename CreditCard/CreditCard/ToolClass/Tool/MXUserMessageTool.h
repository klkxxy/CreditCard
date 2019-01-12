//
//  LNUserMessageTool.h
//  LilacNight
//
//  Created by LilacNight on 2018/8/18.
//  Copyright © 2018年 LilacNight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXUserMessage.h"

@interface MXUserMessageTool : NSObject

+(MXUserMessage *)message;
+(void)clearMessgae;
+(void)saveUserMessage:(MXUserMessage *)message;

@end
