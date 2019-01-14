//
//  MXAddCreditController.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXChoiceBankController.h"
#import "MXChoiceBankCollectionView.h"

@interface MXChoiceBankController ()
@property(nonatomic,strong)MXChoiceBankCollectionView *collectionView;
@end

@implementation MXChoiceBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择银行";
    [self collectionView];
}


-(MXChoiceBankCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[MXChoiceBankCollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-KSafeAreaBottonHeight)];
        _collectionView.navigationController = self.navigationController;
        [self.view addSubview:_collectionView];
    }
    return  _collectionView;
}

@end
