//
//  MXRegisterView.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/11.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXRegisterView.h"

#import "MXMainController.h"

@interface MXRegisterView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *next_btn;
@end
@implementation MXRegisterView
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initCustomerControls];
}

- (void)initCustomerControls {
    
    self.phone_TF.delegate = self;
    self.password_TF.delegate = self;
    
    self.next_btn.enabled = NO;

    [NSNotificationCenter_defaultCenter addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

#pragma mark - UITextFieldDelegate -
- (void)textFieldDidChange:(NSNotification *)notification {
    if (self.phone_TF.text.length != 0 && self.password_TF.text.length != 0) {
        self.next_btn.enabled = YES;
        self.next_btn.backgroundColor = MX_BUTTON_COLOR;
    }else {
        self.next_btn.enabled = NO;
        self.next_btn.backgroundColor = MX_BUTTON_Noselect_COLOR;
    }
}

#pragma mark - 点击事件 -
- (IBAction)nextBtnClick:(UIButton *)sender {
    
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    
    if (_regBlock) {
        _regBlock();
    }

}

+ (instancetype)initMXRegisterView {
    return NSbunleloadNibName(@"MXRegisterView");
}


@end
