//
//  MXMyMediaCell.m
//  LilacNight
//
//  Created by LilacNight on 2018/8/19.
//  Copyright © 2018年 LilacNight. All rights reserved.
//

#import "MXMyMediaCell.h"


@implementation MXMyMediaCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    MXMyMediaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = NSbunleloadNibName(@"MXMyMediaCell");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    return cell;
}


@end
