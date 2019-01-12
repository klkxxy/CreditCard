//
//  MXMyMediaCell.h
//  LilacNight
//
//  Created by LilacNight on 2018/8/19.
//  Copyright © 2018年 LilacNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXMyMediaCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *LicMyPageModMediadict;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;

@end
