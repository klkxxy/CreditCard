//
//  MXAddCreditCollectionView.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

static NSString *collectionCell = @"MXChoiceBankCell";

#import "MXChoiceBankCollectionView.h"
#import "MXChoiceBankCell.h"
#import "MXAddCreditController.h"
#import "CreditCard.h"

@interface MXChoiceBankCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *paramsArr;
@property (strong, nonatomic) NSArray *bankArr;

@end

@implementation MXChoiceBankCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth-3)/3,kScreenWidth/3);
        layout.minimumLineSpacing = 1;//设置每一行的间距
        layout.minimumInteritemSpacing = 1;
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout: layout];
//        [[UICollectionView alloc]initWithFrame:self.bounds];
        
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = MX_GRAY_COLOR;
        [self addSubview:self.collectionView];
        
        UINib *nib = [UINib nibWithNibName:collectionCell bundle:nil];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:collectionCell];
        
    }
    return self;
}

#pragma mark - UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MXChoiceBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    NSDictionary *bank_detail = self.bankArr[indexPath.row];
    cell.bank_detial = bank_detail;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.bankArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *bank_detail = self.bankArr[indexPath.row];
    NSString *bank_name = bank_detail[@"bank_name"];
    if ([bank_name isEqualToString:@"花呗"]) {
        CreditCard *model = [[CreditCard alloc]init];
        model.bank_name = @"花呗";
        model.account_date = 1;
        model.repayment_date = 9;

        //增加
        RLMRealm * realm = [RLMRealm defaultRealm];
        //    [realm beginWriteTransaction]; 这一句 写不写 我目前还没有发现区别
        [realm transactionWithBlock:^{
            //存储数据
            [realm  addObject:model];
            
            //写入数据库
            [realm commitWriteTransaction];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
    }else{
        MXAddCreditController *controller = [[MXAddCreditController alloc]init];
        controller.bank_detial = bank_detail;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

#pragma mark - 懒加载 -
-(NSArray *)bankArr{
    if (!_bankArr) {
        _bankArr = [MXBankDataTool BankData];
    }
    return _bankArr;
}

@end
