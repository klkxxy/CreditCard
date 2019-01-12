//
//  MXRegisterView.h
//  CatchBear
//
//  Created by 王启颖 on 2018/11/11.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXRegisterView : UIView
@property (nonatomic ,copy) void (^regBlock)(void);

@property (weak, nonatomic) IBOutlet UITextField *phone_TF;
@property (weak, nonatomic) IBOutlet UITextField *password_TF;

+ (instancetype)initMXRegisterView;
@end
