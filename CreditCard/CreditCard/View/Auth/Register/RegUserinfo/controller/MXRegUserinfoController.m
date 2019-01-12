//
//  MXRegUserinfoController.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/11.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXRegUserinfoController.h"
#import "MXRegUserinfoView.h"


@interface MXRegUserinfoController ()
@property (strong,nonatomic) MXRegUserinfoView *regUserinfoView;
@end

@implementation MXRegUserinfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"完善个人资料";
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self regUserinfoView];
}


#pragma mark - 懒加载 -
-(MXRegUserinfoView *)regUserinfoView{
    if (!_regUserinfoView) {
        
        MXRegUserinfoView *view = [MXRegUserinfoView initMXRegUserinfoView];
        view.frame = CGRectMake(0,-KSafeAreaTopHeight, kScreenWidth, kScreenHeight-KSafeAreaBottonHeight+KSafeAreaTopHeight);
        _regUserinfoView = view;
        
        [self.view addSubview:_regUserinfoView];
    }
    return _regUserinfoView;
}






@end
