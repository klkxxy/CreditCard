//
//  MXBankDataTool.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/14.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXBankDataTool.h"
#import "CreditCard.h"

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

//获取今天的年月日
+ (NSDateComponents *)getDateComponents{
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    return d;
}

//获取免息日剩余天数
+(NSString *)getDetialRepayment_date:(NSInteger)account_date toDate:(NSInteger)repayment_date dateComponent:(NSDateComponents *)getDateComponents{
    NSDateComponents *d = getDateComponents;
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
+ (NSInteger)remainingPaymentDater:(NSInteger)account_date toDate:(NSInteger)repayment_date dateComponent:(NSDateComponents *)getDateComponents{
    NSDateComponents *d = getDateComponents;
    
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSInteger day = [d day];

    //免息期等于绝对免息期（即账单日和还款日之间的日期）+ 当前日期和下一个还款日之间的日期
    
    
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

//获取最好的卡
+(NSDictionary *)getBestCard:(NSDateComponents *)getDateComponents{
     RLMResults *tempArray = [CreditCard allObjectsInRealm:[RLMRealm defaultRealm]];
    
    NSInteger mianxi = 0;
    CreditCard *bestCard;
    NSMutableArray *bestCardArr = [[NSMutableArray alloc]init];
    for (CreditCard *model in tempArray) {
        
        NSInteger m = [MXBankDataTool remainingPaymentDater:model.account_date toDate:model.repayment_date dateComponent:getDateComponents];
        if (m > mianxi) {
            mianxi = m;
            bestCard = model;
            bestCardArr = [[NSMutableArray alloc]init];
        }else if (m == mianxi){
            [bestCardArr addObject:model];
        }
    }
    [bestCardArr addObject:bestCard];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:mianxi],@"mianxi",bestCardArr,@"bestCardArr", nil];
    
    return dic;
    
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

+(UIColor *)getBankColor:(NSString *)bankName{
    if ([bankName isEqualToString:@"招商银行"]) {
        return UIHexColor(@"#FFFF00");
    }else if ([bankName isEqualToString:@"中信银行"]){
        return UIHexColor(@"#FFA07A");
    }else if ([bankName isEqualToString:@"建设银行"]){
        return UIHexColor(@"#FF8247");
    }else if ([bankName isEqualToString:@"平安银行"]){
        return UIHexColor(@"#FF83FA");
    }else if ([bankName isEqualToString:@"工商银行"]){
        return UIHexColor(@"#ADFF2F");
    }else if ([bankName isEqualToString:@"中国银行"]){
        return UIHexColor(@"#FF3E96");
    }else if ([bankName isEqualToString:@"农业银行"]){
        return UIHexColor(@"#FFC1C1");
    }else if ([bankName isEqualToString:@"交通银行"]){
        return UIHexColor(@"#FF0000");
    }else if ([bankName isEqualToString:@"光大银行"]){
        return UIHexColor(@"#D02090");
    }else if ([bankName isEqualToString:@"民生银行"]){
        return UIHexColor(@"#CDC673");
    }else if ([bankName isEqualToString:@"浦发银行"]){
        return UIHexColor(@"#CD2626");
    }else if ([bankName isEqualToString:@"邮政储蓄银行"]){
        return UIHexColor(@"#BCD2EE");
    }else if ([bankName isEqualToString:@"华夏银行"]){
        return UIHexColor(@"#B0B0B0");
    }else if ([bankName isEqualToString:@"兴业银行"]){
        return UIHexColor(@"#A020F0");
    }else if ([bankName isEqualToString:@"广发银行"]){
        return UIHexColor(@"#ADFF2F");
    }else if ([bankName isEqualToString:@"花旗银行"]){
        return UIHexColor(@"#969696");
    }else if ([bankName isEqualToString:@"宁波银行"]){
        return UIHexColor(@"#8B6914");
    }else if ([bankName isEqualToString:@"上海银行"]){
        return UIHexColor(@"#8B4C39");
    }else if ([bankName isEqualToString:@"成都银行"]){
        return UIHexColor(@"#87CEFA");
    }else if ([bankName isEqualToString:@"杭州银行"]){
        return UIHexColor(@"#848484");
    }else if ([bankName isEqualToString:@"广州农商银行"]){
        return UIHexColor(@"#836FFF");
    }else if ([bankName isEqualToString:@"北京银行"]){
        return UIHexColor(@"#7D26CD");
    }else if ([bankName isEqualToString:@"福建农信银行"]){
        return UIHexColor(@"#7FFF00");
    }else if ([bankName isEqualToString:@"杭州联合银行"]){
        return UIHexColor(@"#7CCD7C");
    }else if ([bankName isEqualToString:@"南京银行"]){
        return UIHexColor(@"#6B8E23");
    }else if ([bankName isEqualToString:@"江苏银行"]){
        return UIHexColor(@"#66CD00");
    }else if ([bankName isEqualToString:@"浙江农信"]){
        return UIHexColor(@"#436EEE");
    }else if ([bankName isEqualToString:@"浙商银行"]){
        return UIHexColor(@"#2E2E2E");
    }else if ([bankName isEqualToString:@"花呗"]){
        return UIHexColor(@"#99ccff");
    }else{
        return UIHexColor(@"#00FF00");
    }
}


@end
