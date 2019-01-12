//
//  LZPickerView.h
//  PickerVIew
//
//  Created by 栗子 on 2018/3/9.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LZPickerViewType){
    LZPickerViewTypeSexAndHeight,//性别身高类型
    LZPickerViewTypeWeigth,//体重
};

@interface LZPickerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIPickerView *lzPickerView;

@property (weak, nonatomic) IBOutlet UIView *bgVIew;
@property (weak, nonatomic) IBOutlet UIView *toolBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;

//数据
@property(nonatomic,strong)NSArray *dataSource;
//默认选中
@property (nonatomic, copy) NSString *selectDefault;
//选中值
@property(nonatomic,copy)void(^selectValue)(NSString *value,NSInteger row);
//标题
@property (nonatomic, copy) NSString *titleText;

//显示
- (void)show;
//设置pickerVIew的类型
-(void)lzPickerVIewType:(LZPickerViewType)type;


@end
