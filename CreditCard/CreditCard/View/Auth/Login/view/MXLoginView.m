//
//  PCChatLoginView.m
//  MXUserSys
//
//  Created by MXUserSys on 2018/6/12.
//  Copyright © 2018年 MXUserSys. All rights reserved.
//

#import "MXLoginView.h"

@interface MXLoginView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *login_btn;
@property (weak, nonatomic) IBOutlet UIButton *forget_btn;
@property (weak, nonatomic) IBOutlet UIView *lineOneView;
@property (weak, nonatomic) IBOutlet UIView *lineTwoView;


@end

@implementation MXLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initCustomerControls];
}

- (void)initCustomerControls {
    _account_TF.textColor = MX_BLACK_COLOR;
    _psd_TF.textColor = MX_BLACK_COLOR;
    [_forget_btn setTitleColor:MX_FONTGRAY_COLOR forState:UIControlStateNormal];

    self.account_TF.delegate = self;
    self.psd_TF.delegate = self;
    self.login_btn.enabled = NO;
    [NSNotificationCenter_defaultCenter addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];

}

#pragma mark - UITextFieldDelegate -

- (void)textFieldDidChange:(NSNotification *)notification {
    if (self.account_TF.text.length != 0 && self.psd_TF.text.length != 0) {
        self.login_btn.enabled = YES;
        self.login_btn.backgroundColor = MX_BUTTON_COLOR;
    }else {
        self.login_btn.enabled = NO;
        self.login_btn.backgroundColor = MX_BUTTON_Noselect_COLOR;
    }
}

#pragma mark - btnClick -

- (IBAction)btnClick:(UIButton *)sender {
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    
    if (_accountBlock) {
        _accountBlock(sender.tag - 40);
    }

}


+ (instancetype)initMXLoginView {
    return NSbunleloadNibName(@"MXLoginView");
}

@end
