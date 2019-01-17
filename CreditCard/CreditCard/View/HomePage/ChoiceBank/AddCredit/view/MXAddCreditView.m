//
//  MXAddCreditView.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/11.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXAddCreditView.h"
#import "LZPickerView.h"
#import "CreditCard.h"
#import "WLDecimalKeyboard.h"

@interface MXAddCreditView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bank_logo_imgV;
@property (weak, nonatomic) IBOutlet UILabel *bank_name_lbl;
@property (nonatomic,strong) LZPickerView *lzPickerVIew;
@property (nonatomic,strong) NSArray *dateArr;
@property (weak, nonatomic) IBOutlet UILabel *account_date_lbl;
@property (weak, nonatomic) IBOutlet UILabel *repayment_date_lbl;
@property (nonatomic, assign) NSInteger account_date;   //出账日
@property (nonatomic, assign) NSInteger repayment_date;  //还款日
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextF;

@end
@implementation MXAddCreditView
- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LZPickerView" owner:nil options:nil];
    self.lzPickerVIew  = views[0];
    
    WLDecimalKeyboard *inputView = [[WLDecimalKeyboard alloc] init];
    self.bankCardTextF.delegate = self;
    self.bankCardTextF.backgroundColor = [UIColor whiteColor];
    self.bankCardTextF.placeholder = @"请输入针数";
    self.bankCardTextF.inputView = inputView;
    [self.bankCardTextF reloadInputViews];
}

- (void)setBank_detial:(NSDictionary *)bank_detial{
    _bank_detial = bank_detial;
    NSString *b_logo = [bank_detial[@"logo"] componentsSeparatedByString:@"-"][0];
    NSString *logo = [NSString stringWithFormat:@"bank_icon_%@",b_logo];
    self.bank_logo_imgV.image = [UIImage imageNamed:logo];
    self.bank_name_lbl.text = bank_detial[@"bank_name"];
}

+ (instancetype)initMXAddCreditView {
    return NSbunleloadNibName(@"MXAddCreditView");
}

- (IBAction)accout_date_selectClick:(id)sender {
    [_bankCardTextF resignFirstResponder];
    
    [self.lzPickerVIew lzPickerVIewType:LZPickerViewTypeSexAndHeight];
    self.lzPickerVIew.dataSource = self.dateArr;
    self.lzPickerVIew.titleText = @"每月出账日";
    __weak typeof(self) weakself = self;
    self.lzPickerVIew.selectValue = ^(NSString *value, NSInteger row) {
        weakself.account_date_lbl.text = [NSString stringWithFormat:@"每月%@日",value];
        weakself.account_date = row + 1;
        weakself.account_date_lbl.textColor = MX_BLACK_COLOR;
    };
    [self.lzPickerVIew show];
    
}
- (IBAction)repayment_date_selectClick:(id)sender {
    [_bankCardTextF resignFirstResponder];
    
    [self.lzPickerVIew lzPickerVIewType:LZPickerViewTypeSexAndHeight];
    self.lzPickerVIew.dataSource = self.dateArr;
    self.lzPickerVIew.titleText = @"每月还款日";
    __weak typeof(self) weakself = self;
    self.lzPickerVIew.selectValue = ^(NSString *value, NSInteger row) {
        weakself.repayment_date_lbl.text = [NSString stringWithFormat:@"每月%@日",value];
        weakself.repayment_date = row + 1;
        weakself.repayment_date_lbl.textColor = MX_BLACK_COLOR;
    };
    [self.lzPickerVIew show];
}

- (IBAction)addCreditClick:(id)sender {
    [_bankCardTextF resignFirstResponder];
    
    CreditCard *model = [[CreditCard alloc]init];
    model.bank_name = self.bank_detial[@"bank_name"];
    model.card_num = self.bankCardTextF.text;
    model.account_date = self.account_date;
    model.repayment_date = self.repayment_date;
    
    if([model.card_num length] == 0){
        [SVProgressHUD showImage:NULL_IMAGE status:@"请输入卡号"];
        return;
    }
    if (!self.account_date) {
        [SVProgressHUD showImage:NULL_IMAGE status:@"请选择出账日"];
        return;
    }
    if (!self.repayment_date) {
        [SVProgressHUD showImage:NULL_IMAGE status:@"请选择还款日"];
        return;
    }
    
    //增加
    RLMRealm * realm = [RLMRealm defaultRealm];
    //    [realm beginWriteTransaction]; 这一句 写不写 我目前还没有发现区别
    [realm transactionWithBlock:^{
        //存储数据
        [realm  addObject:model];
        
        //写入数据库
        [realm commitWriteTransaction];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}

#pragma mark - UITextFieldDelegate -
/// 设置自定义键盘后，delegate 不会被调用？
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@", [textField.text stringByReplacingCharactersInRange:range withString:string]);
    
    return YES;
}

-(NSArray *)dateArr{
    if (!_dateArr) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i = 1; i<27; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        _dateArr = [NSArray arrayWithArray:arr];
    }
    return _dateArr;
}
@end
