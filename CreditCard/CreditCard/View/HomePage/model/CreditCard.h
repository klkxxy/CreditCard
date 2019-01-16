//
//  CreditCard.h
//  CreditCard
//
//  Created by 王启颖 on 2019/1/13.
//  Copyright © 2019 王启颖. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface CreditCard : RLMObject

@property (nonatomic, strong) NSString *bank_name;
@property (nonatomic, strong) NSString *card_num;
@property (nonatomic, assign) NSInteger account_date;   //出账日
@property (nonatomic, assign) NSInteger repayment_date;  //还款日
@end

NS_ASSUME_NONNULL_END
