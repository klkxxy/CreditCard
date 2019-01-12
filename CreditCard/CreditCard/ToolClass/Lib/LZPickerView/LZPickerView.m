//
//  LZPickerView.m
//  PickerVIew
//
//  Created by 栗子 on 2018/3/9.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


#import "LZPickerView.h"

@interface LZPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign)NSInteger       number;//几列
@property (nonatomic,strong)NSMutableArray   *leftArr;//两列时左侧数据
@property (nonatomic,strong)NSMutableArray   *rightArr;//两列时右侧数据
@property (nonatomic,copy)  NSString         *left;//两列时左侧选中数据
@property (nonatomic,copy)  NSString         *right;//两列时右侧选中数据
@property (nonatomic, assign) NSInteger      selectRow;//当前选中

@end

@implementation LZPickerView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.lzPickerView.delegate = self;
    self.lzPickerView.dataSource = self;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    self.leftArr = [NSMutableArray array];
    self.rightArr = [NSMutableArray array];
}

/**
 类型
 */
-(void)lzPickerVIewType:(LZPickerViewType)type{
    if (type == LZPickerViewTypeSexAndHeight ) {
        self.number =1;
    }else if (type == LZPickerViewTypeWeigth){
        self.number = 2;
    }
}

#pragma mark UIPickerViewDelegate && UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.number;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.number==1) {
        return self.dataSource.count;
    }else if (self.number==2){
        NSInteger result = 0;
        switch (component) {
            case 0:
                result = self.leftArr.count;
                break;
            case 1:
                result = self.rightArr.count;
            default:
                break;
        }
        return result;

    }
    return 0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.number==1) {
        return self.dataSource[row];
    }else if (self.number==2){
        NSString *content = nil;
        switch (component) {
            case 0:
                content = self.leftArr[row];
                break;
            case 1:
                content = self.rightArr[row];
                break;
            default:
                break;
        }
        return content;
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.number==1) {
        self.selectRow = row;
        self.selectDefault = [NSString stringWithFormat:@"%@",self.dataSource[row]];
    }else if (self.number==2){
        switch (component) {
            case 0:
                [pickerView selectRow:[pickerView selectedRowInComponent:0] inComponent:0 animated:NO];
                self.left = self.leftArr[row];
                break;
            case 1:{
                [pickerView selectRow:[pickerView selectedRowInComponent:1] inComponent:1 animated:NO];
                self.right = self.rightArr[row];
                self.selectRow = row;
                [pickerView reloadComponent:1];
            }
                break;
            default:
                break;
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    /*设置线条颜色
     for(UIView *singleLine in pickerView.subviews)
         {
             if (singleLine.frame.size.height < 1)
             {
                 singleLine.backgroundColor = [UIColor yellowColor];
             }
         }
     */
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    if (self.number==1) {
         label.text = [NSString stringWithFormat:@"%@",self.dataSource[row]];
    }else{
        if (component == 0) {
            label.text = self.leftArr[row];
        }else if (component == 1){
            label.text = [NSString stringWithFormat:@"%@",self.rightArr[row]];
            if (row == self.selectRow) {
                label.text = [NSString stringWithFormat:@".%@",self.rightArr[row]];
            }
        }
    }
     return label;
}

/**
 取消
 */
- (IBAction)cancelBtn:(id)sender {
    [self removeSelfFromSupView];
    
}

/**
 确定
 */
- (IBAction)sureBtn:(id)sender {
    if (self.number ==1) {
        if (self.selectValue) {
            self.selectValue(self.selectDefault,self.selectRow);
        }
    }else if (self.number==2){
//        NSString *text = [NSString stringWithFormat:@"%@.%@kg",self.left,self.right];
//        if (self.selectValue) {
//            self.selectValue(text);
//        }
    }
    
    [self removeSelfFromSupView];
}
/**
 弹出视图
 */
- (void)show
{
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    //动画出现
    CGRect frame = self.bgVIew.frame;
    if (frame.origin.y == SCREEN_HEIGHT) {
        frame.origin.y -= self.bgViewHeight.constant;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgVIew.frame = frame;
        }];
    }
}

/**
 移除视图
 */
- (void)removeSelfFromSupView
{
    CGRect selfFrame = self.bgVIew.frame;
    if (selfFrame.origin.y == SCREEN_HEIGHT - self.bgViewHeight.constant) {
        selfFrame.origin.y += self.bgViewHeight.constant;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgVIew.frame = selfFrame;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/**
 点击空白关闭
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeSelfFromSupView];
}

/**
 数据源
 */
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    if (self.number==1) {
        self.selectDefault = [NSString stringWithFormat:@"%@",dataSource[0]];
        
    }else if (self.number==2){
        self.leftArr = [NSMutableArray arrayWithArray:dataSource[0]];
        self.rightArr = [NSMutableArray arrayWithArray:dataSource[1]];
        self.left = self.leftArr[0];
        self.right = self.rightArr[0];
    }
     //刷新pickerview数据
    [self.lzPickerView setNeedsLayout];
    [self.lzPickerView reloadAllComponents];
    [self.lzPickerView selectRow:0 inComponent:0 animated:NO];
    
}

/**
 默认选择值
 */
-(void)setSelectDefault:(NSString *)selectDefault{
    _selectDefault = selectDefault;
    if (self.number==1) {
        for (NSInteger i=0; i<_dataSource.count; i++) {
            NSString *text = [NSString stringWithFormat:@"%@",_dataSource[i]];
            if ([text isEqualToString:selectDefault]) {
                [self.lzPickerView selectRow:i inComponent:0 animated:NO];
            }
        }
    }else if (self.number==2){
        NSString *weight = [selectDefault stringByReplacingOccurrencesOfString:@"kg" withString:@""];
        NSArray *weihtArray = [weight componentsSeparatedByString:@"."];
        if (weihtArray.count) {
            NSString *left = [NSString stringWithFormat:@"%@",weihtArray[0]];
            NSString *right ;
            if (weihtArray.count>1) {
                right  = [NSString stringWithFormat:@"%@",weihtArray[1]];
            }else{
                right = [NSString stringWithFormat:@"%@",self.rightArr[0]];
            }
            for (int i=0; i<self.leftArr.count; i++) {
                if ([[self.leftArr objectAtIndex:i] isEqualToString:left]) {
                    [self.lzPickerView selectRow:i inComponent:0 animated:NO];
                }
            }
            for (int j=0; j<self.rightArr.count; j++) {
                if ([[self.rightArr objectAtIndex:j] isEqualToString:right]) {
                    [self.lzPickerView selectRow:j inComponent:1 animated:NO];
                    self.selectRow = j;
                }
            }
            self.left = left;
            self.right = right;
        }
    }
}

/**
 标题
 */
-(void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    self.titleLB.text = titleText;
}


@end
