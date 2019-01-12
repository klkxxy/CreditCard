//
//  MXMyTableView.m
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/19.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXMyTableView.h"
#import "MXMyMediaCell.h"
#import "LNMyHeaderView.h"

@interface MXMyTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *paramsArr;

@end

@implementation MXMyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = MX_GRAY_COLOR;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        LNMyHeaderView *headerView = [LNMyHeaderView initLNMyHeaderView];
        headerView.frame = CGRectMake(0,0, kScreenWidth, 240.f);
        self.tableView.tableHeaderView = headerView;
        
        [self addSubview:self.tableView];
        
    }
    return self;
}



#pragma mark - UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXMyMediaCell *cell = [MXMyMediaCell cellWithTableView:tableView];
    cell.name_lbl.text = @"退出";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MXPublicRequstClass LogoutReloadRequst];
    
}

#pragma mark - 懒加载 -
-(NSMutableArray *)paramsArr{
    if (!_paramsArr) {
        _paramsArr = [[NSMutableArray alloc]init];
    }
    return _paramsArr;
}


@end
