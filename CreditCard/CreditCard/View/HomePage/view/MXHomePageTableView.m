//
//  MXHomePageTableView.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXHomePageTableView.h"
#import "MXHomePageCell.h"
#import "MXHomePageFootView.h"
#import "MXChoiceBankController.h"
#import "CreditCard.h"

@interface MXHomePageTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *paramsArr;
@property (nonatomic, strong) RLMResults * tempArray;
@property (strong, nonatomic) NSArray *bankArr;
@end

@implementation MXHomePageTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = MX_GRAY_COLOR;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
//        LNMyHeaderView *headerView = [LNMyHeaderView initLNMyHeaderView];
//        headerView.frame = CGRectMake(0,0, kScreenWidth, 240.f);
//        self.tableView.tableHeaderView = headerView;
        
        MXHomePageFootView *footView = [MXHomePageFootView initMXHomePageFootView];
        footView.frame = CGRectMake(0, 0, kScreenWidth, 150.f);
        __weak typeof(self) weakself = self;
        footView.footBlock = ^{
            [weakself.navigationController pushViewController:[[MXChoiceBankController alloc]init] animated:true];
        };
        self.tableView.tableFooterView = footView;
        
        [self addSubview:self.tableView];
        
//        [self getAllCreditCard];
        
    }
    return self;
}
//
//-(void)getAllCreditCard{
//    self.tempArray =
//    [self.tableView reloadData];
//
//
//}


#pragma mark - UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXHomePageCell *cell = [MXHomePageCell cellWithTableView:tableView];
    cell.bankArr = self.bankArr;
    CreditCard *model = self.tempArray[indexPath.row];
    cell.model = model;
    NSLog(@"%@",self.tempArray[indexPath.row]);

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[MXChoiceBankController new] animated:true];
}

#pragma mark - 懒加载 -
-(NSMutableArray *)paramsArr{
    if (!_paramsArr) {
        _paramsArr = [[NSMutableArray alloc]init];
    }
    return _paramsArr;
}

-(RLMResults *) tempArray{
    if (!_tempArray) {
        _tempArray = [CreditCard allObjectsInRealm:[RLMRealm defaultRealm]];
        [self.tableView reloadData];
    }
    return _tempArray;
}

-(NSArray *)bankArr{
    if (!_bankArr) {
        _bankArr = [MXBankDataTool BankData];
    }
    return _bankArr;
}

@end
