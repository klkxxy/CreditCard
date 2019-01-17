//
//  MXAddCreditController.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/11.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXAddCreditController.h"
#import "MXAddCreditView.h"

@interface MXAddCreditController ()
@property (strong,nonatomic) MXAddCreditView *addCreditView;
@end

@implementation MXAddCreditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCreditView];
}

#pragma mark - 懒加载 -
-(MXAddCreditView *)addCreditView{
    if (!_addCreditView) {
        
        MXAddCreditView *view = [MXAddCreditView initMXAddCreditView];
        view.bank_detial = self.bank_detial;
        view.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight-KSafeAreaBottonHeight);
        view.navigationController = self.navigationController;
        _addCreditView = view;
        
        [self.view addSubview:_addCreditView];
    }
    return _addCreditView;
}



@end
