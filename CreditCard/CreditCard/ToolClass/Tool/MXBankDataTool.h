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

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSInteger)remainingPaymentDater;

@end

NS_ASSUME_NONNULL_END
