//
//  MXBankDataTool.h
//  CreditCard
//
//  Created by 王启颖 on 2019/1/14.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXBankDataTool : NSObject

+(NSArray *)BankData;


+ (NSInteger)remainingPaymentDater:(NSInteger)account_date toDate:(NSInteger)repayment_date dateComponent:(NSDateComponents *)getDateComponents;


+(NSString *)getDetialRepayment_date:(NSInteger)account_date toDate:(NSInteger)repayment_date dateComponent:(NSDateComponents *)getDateComponents;

+ (NSDateComponents *)getDateComponents;

+(NSDictionary *)getBestCard:(NSDateComponents *)getDateComponents;

+(UIColor *)getBankColor:(NSString *)bankName;
@end

NS_ASSUME_NONNULL_END
