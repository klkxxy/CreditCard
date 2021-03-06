//
//  MXHomePageCell.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXHomePageCell.h"
@interface MXHomePageCell ()
@property (weak, nonatomic) IBOutlet UILabel *bank_name;
@property (weak, nonatomic) IBOutlet UILabel *card_num;
@property (weak, nonatomic) IBOutlet UILabel *repayment_date_count;
@property (weak, nonatomic) IBOutlet UILabel *repayment_date;
@property (weak, nonatomic) IBOutlet UIImageView *logo;


@end
@implementation MXHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CreditCard *)model{
    _model = model;
    self.bank_name.text = model.bank_name;
    self.card_num.text = model.card_num;
    self.repayment_date_count.text = [NSString stringWithFormat:@"%ld",[MXBankDataTool remainingPaymentDater:model.account_date toDate:model.repayment_date dateComponent:[MXBankDataTool getDateComponents]]];
    
    self.repayment_date.text = [MXBankDataTool getDetialRepayment_date:model.account_date toDate:model.repayment_date dateComponent:[MXBankDataTool getDateComponents]];

    for (NSDictionary *dic in self.bankArr) {
        NSString *b_name = dic[@"bank_name"];
        if ([b_name isEqualToString:model.bank_name]) {
            
            NSString *b_logo = [dic[@"logo"] componentsSeparatedByString:@"-"][0];
            NSString *logo = [NSString stringWithFormat:@"bank_icon_%@",b_logo];
            self.logo.image = [UIImage imageNamed:logo];
            break;
        }
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    MXHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = NSbunleloadNibName(@"MXHomePageCell");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    return cell;
}

@end
