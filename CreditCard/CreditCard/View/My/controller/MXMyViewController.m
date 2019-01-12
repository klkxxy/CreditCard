//
//  MXMyViewController.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/19.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXMyViewController.h"
#import "MXMyTableView.h"



@interface MXMyViewController ()
@property(strong,nonatomic)MXMyTableView *tableview;
@end

@implementation MXMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableview];
    [self SetNavigationClear];

}


#pragma mark - 懒加载 -
-(MXMyTableView *)tableview{
    if (!_tableview) {
        _tableview = [[MXMyTableView alloc]initWithFrame:CGRectMake(0,-KSafeAreaTopHeight, kScreenWidth, kScreenHeight-kTabBarViewHeight-KSafeAreaBottonHeight)];
        _tableview.navigationController = self.navigationController;
        _tableview.backgroundColor = [UIColor redColor];
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}
@end
