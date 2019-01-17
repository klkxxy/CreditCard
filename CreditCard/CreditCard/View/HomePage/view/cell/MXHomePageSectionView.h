//
//  MXHomePageSectionView.h
//  CreditCard
//
//  Created by 王启颖 on 2019/1/18.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXHomePageSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *bank_name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *repayment_date_count;

+ (instancetype)initMXHomePageSectionView;
@end

NS_ASSUME_NONNULL_END
