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

@interface MXChoiceBankCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *paramsArr;

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
        
//        layout.minimumLineSpacing = 10;//设置每一行的间距
//        layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);//item对象上下左右的距离
//        self.collectionView.collectionViewLayout = layout;
        
    }
    return self;
}

#pragma mark - UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MXChoiceBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
   
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MXAddCreditController *controller = [[MXAddCreditController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
