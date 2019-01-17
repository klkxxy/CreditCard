//
//  MXAddCreditCardCell.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/10.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXChoiceBankCell.h"

@interface MXChoiceBankCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bank_logo_imgV;
@property (weak, nonatomic) IBOutlet UILabel *bank_name_lbl;

@end

@implementation MXChoiceBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBank_detial:(NSDictionary *)bank_detial{
    _bank_detial = bank_detial;
    
    NSString *b_logo = [bank_detial[@"logo"] componentsSeparatedByString:@"-"][0];
    NSString *logo = [NSString stringWithFormat:@"bank_icon_%@",b_logo];
    self.bank_logo_imgV.image = [UIImage imageNamed:logo];
    self.bank_name_lbl.text = bank_detial[@"bank_name"];
    
}


@end
