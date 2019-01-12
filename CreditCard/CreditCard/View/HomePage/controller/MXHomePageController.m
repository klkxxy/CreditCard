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
