//
//  MXBankDataTool.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/14.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXBankDataTool.h"

@implementation MXBankDataTool

+(NSArray *)BankData{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    id jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    
    //功能栏数据
    NSArray *functionArr = jsonObject;
    return functionArr;
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
}

//获取今天的年月日
+ (NSDateComponents *)getDateComponents{
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    return d;
}

//获取详细还款日
+(NSString *)getDetialRepayment_date:(NSInteger)account_date toDate:(NSInteger)repayment_date{
    NSDateComponents *d = [MXBankDataTool getDateComponents];
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSInteger day = [d day];
    
    if (day < account_date) {
        //还没到出账日，免息期=当前日到下一个账单月
        if (day < repayment_date) {
            return [NSString stringWithFormat:@"%ld-%ld",month,repayment_date];
        }else{
            //当前月有多少天
            if (month + 1 == 13) {
                return [NSString stringWithFormat:@"1-%ld",repayment_date];
            }else{
                return [NSString stringWithFormat:@"%ld-%ld",month+1,repayment_date];
            }
        }
    }else{
        //已经过了本月的出账日，免息期等于当前日到下下个账单月
        if (day < repayment_date) {
            //当前月有多少天
            if (month + 1 == 13) {
                return [NSString stringWithFormat:@"%ld-1-%ld",year+1,repayment_date];
            }else{
                return [NSString stringWithFormat:@"%ld-%ld",month+1,repayment_date];
            }
        }else{
            if (month == 11) {
                return [NSString stringWithFormat:@"%ld-1-%ld",year+1,repayment_date];
            }else if (month == 12){
                return [NSString stringWithFormat:@"%ld-2-%ld",year+1,repayment_date];
            }else{
                return [NSString stringWithFormat:@"%ld-%ld",month+2,repayment_date];
            }
        }
        
    }
    
}

//account_date出账日 repayment_date还款日
+ (NSInteger)remainingPaymentDater:(NSInteger)account_date toDate:(NSInteger)repayment_date{
    NSDateComponents *d = [MXBankDataTool getDateComponents];
    
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSInteger day = [d day];

    if (day < account_date) {
        //还没到出账日，免息期=当前日到下一个账单月
        if (day < repayment_date) {
            return repayment_date - day;
        }else{
            //当前月有多少天
            NSInteger month_dayCount = [MXBankDataTool dayOfMonth:month andYear:year];
            return month_dayCount - day + repayment_date;
        }
    }else{
        //已经过了本月的出账日，免息期等于当前日到下下个账单月
        if (day < repayment_date) {
            //当前月有多少天
            NSInteger month_dayCount = [MXBankDataTool dayOfMonth:month andYear:year];
            return repayment_date - day + month_dayCount;
        }else{
            //当前月有多少天
            NSInteger month_dayCount = [MXBankDataTool dayOfMonth:month andYear:year];
            //下一个月有多少天
            NSInteger next_month_dayCount;
            if (month + 1 == 13) {
                next_month_dayCount = [MXBankDataTool dayOfMonth:1 andYear:year + 1];
            }else{
                next_month_dayCount = [MXBankDataTool dayOfMonth:month + 1 andYear:year];
            }

            return month_dayCount + next_month_dayCount - (day - repayment_date);
        }
        
    }
    return 0;
}

+(NSInteger)dayOfMonth:(NSInteger)month andYear:(NSInteger)year{
    switch (month) {
        case 1:
            return 31;
        case 2:
            if (year%4) {
                return 28;
            }
            return 29;
        case 3:
            return 31;
        case 4:
            return 30;
        case 5:
            return 31;
        case 6:
            return 30;
        case 7:
            return 31;
        case 8:
            return 31;
        case 9:
            return 30;
        case 10:
            return 31;
        case 11:
            return 30;
        case 12:
            return 31;
           
        default:
            return 30;
    }
}




@end
