//
//  MXHomePageController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXHomePageController.h"

#import "MXHomePageTableView.h"


@interface MXHomePageController ()
@property(strong,nonatomic)MXHomePageTableView *tableview;
@end

@implementation MXHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"首页";
    [self tableview];
    
//    // 默认配置
//
//    // 获取 Realm 文件的父目录
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *folderPath = realm.configuration.fileURL.URLByDeletingLastPathComponent.path;
    NSLog(@"%@",folderPath);
    
//    // 禁用此目录的文件保护
//
//    CreditCard *card = [[CreditCard alloc] init];
//    card.bank_name = @"中国银行";
//    card.card_num = @"123123123";
//    card.account_date = @"1";
//    card.repayment_date = @"10";
//
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//
//        //存储数据
//        [realm  addObject:card];
//
//        //写入数据库
//        [realm commitWriteTransaction];
//
//    }];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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


@end
