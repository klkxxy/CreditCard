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

@property (assign, nonatomic) BOOL isTimingPush;

//保存token
-(void)SaveIsTimingPushToSandbox;
-(void)LoadIsTimingPushFromSandbox;






@end
