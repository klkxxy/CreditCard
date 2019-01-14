//
//  MXHomePageCell.h
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXHomePageCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CreditCard *model;

@end

NS_ASSUME_NONNULL_END
