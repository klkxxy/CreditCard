//
//  LNMyHeaderView.m
//  LilacNight
//
//  Created by LilacNight on 2018/8/19.
//  Copyright © 2018年 LilacNight. All rights reserved.
//


#import "LNMyHeaderView.h"

@interface LNMyHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeader_image;

@end

@implementation LNMyHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

    [self initHeaderData];
}

- (void)initHeaderData {
    
    self.backgroundColor = MX_MAIN_COLOR;
    _lineView.backgroundColor = MX_LINE_COLOR;
    
    [self.userHeader_image changeCornerRadius:self.userHeader_image.width/2];
    
    MXUserMessage *message = [MXUserMessageTool message];
    self.name_lbl.text = message.user_nickname;
    
    [self.userHeader_image sd_setImageWithURL:[NSURL URLWithString:message.user_headimg] placeholderImage:[UIImage imageNamed:@"photoAndVideoDefault"]];
 
   
}

+ (instancetype)initLNMyHeaderView {
    return NSbunleloadNibName(@"LNMyHeaderView");
}

@end
