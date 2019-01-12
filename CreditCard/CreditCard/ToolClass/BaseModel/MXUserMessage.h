//
//  MXUserMessage.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/17.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXUserMessage : NSObject
singleton_interface(MXUserMessage)

@property(nonatomic,strong)NSString *user_phone;
@property(nonatomic,strong)NSString *user_nickname;
@property(nonatomic,strong)NSString *user_headimg;
@property(nonatomic,strong)NSString *user_id;

@end
