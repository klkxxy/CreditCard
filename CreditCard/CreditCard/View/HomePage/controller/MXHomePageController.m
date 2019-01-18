//
//  MXHomePageController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXHomePageController.h"
#import "MXTimingPushViewController.h"

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
    
    [self barButtonItemName:nil withImageName:@"remind" targer:@"timingPushViewClick" isRight:YES];
    
}

-(void)timingPushViewClick{
    MXTimingPushViewController *controller = [[MXTimingPushViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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










@end
