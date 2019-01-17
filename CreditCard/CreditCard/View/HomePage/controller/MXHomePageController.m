//
//  MXHomePageController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXHomePageController.h"

#import "MXHomePageTableView.h"
#import "MXBankDataTool.h"
#import "CreditCard.h"

@interface MXHomePageController ()
@property(strong,nonatomic)MXHomePageTableView *tableview;
@end

@implementation MXHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    // 获取 Realm 文件的父目录
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *folderPath = realm.configuration.fileURL.URLByDeletingLastPathComponent.path;
    NSLog(@"%@",folderPath);
    
    
    self.title = @"首页";
    [self tableview];
    
    [self getBestCard:[MXBankDataTool getDateComponents]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableview reloadData];

}

#pragma mark - 懒加载 -
-(MXHomePageTableView *)tableview{
    if (!_tableview) {
        _tableview = [[MXHomePageTableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-kTabBarViewHeight-KSafeAreaBottonHeight)];
        _tableview.navigationController = self.navigationController;
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}

//获取最好的卡
-(NSDictionary *)getBestCard:(NSDateComponents *)getDateComponents{
    RLMResults *tempArray = [CreditCard allObjectsInRealm:[RLMRealm defaultRealm]];
    
    NSInteger mianxi = 0;
    CreditCard *bestCard;
    for (CreditCard *model in tempArray) {
        
        NSInteger m = [MXBankDataTool remainingPaymentDater:model.account_date toDate:model.repayment_date dateComponent:getDateComponents];
        if (m > mianxi) {
            mianxi = m;
            bestCard = model;
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:mianxi],@"mainxi",bestCard,@"bestCard", nil];

    return dic;
    
}











@end
