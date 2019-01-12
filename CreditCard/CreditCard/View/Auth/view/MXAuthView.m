//
//  MXAuthView.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXAuthView.h"

#import "MXLoginController.h"
#import "MXRegisterController.h"

@interface MXAuthView ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation MXAuthView
- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self initCustomerControls];
}

- (void)initCustomerControls {
    self.loginBtn.backgroundColor = MX_MAIN_COLOR;
    [self.loginBtn changeCornerRadius:self.loginBtn.height/2];
    
    [self.registerBtn changeCornerRadius:self.registerBtn.height/2];
    [self.registerBtn changeLayer:MX_MAIN_COLOR borderWidth:1];
}
- (IBAction)loginBtnClick:(id)sender {

    [self.navigationController pushViewController:[MXLoginController new] animated:YES];
}

- (IBAction)registerBtnClick:(id)sender {
    [self.navigationController pushViewController:[MXRegisterController new] animated:YES];
}
+ (instancetype)initMXAuthView {
    return NSbunleloadNibName(@"MXAuthView");
}

@end
