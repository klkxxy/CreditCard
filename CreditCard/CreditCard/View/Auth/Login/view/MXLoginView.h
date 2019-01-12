//
//  PCChatLoginView.h
//  MXUserSys
//
//  Created by MXUserSys on 2018/6/12.
//  Copyright © 2018年 MXUserSys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXLoginView : UIView
@property (nonatomic ,copy) void (^accountBlock)(NSInteger btnTag);


@property (weak, nonatomic) IBOutlet UITextField *account_TF;
@property (weak, nonatomic) IBOutlet UITextField *psd_TF;

+ (instancetype)initMXLoginView;

@end
