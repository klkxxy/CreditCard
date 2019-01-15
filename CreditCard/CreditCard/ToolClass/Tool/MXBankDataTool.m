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

@end
