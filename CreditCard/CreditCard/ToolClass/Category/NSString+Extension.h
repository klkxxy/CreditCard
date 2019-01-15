//
//  NSString+Extension.h
//  ZLKNB
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
- (NSString *)md5:(NSString *) input;
- (BOOL)checkEmail;

- (void)clickTelephoneNumber;

-(NSString*)base64String;
//去除./
-(NSString *)delestring;
//去除_thumb
-(NSString *)deleThumstring;
//去除./imagines,获得图片名称
-(NSString *)deleImagestring;

//数字三位添加逗号
-(NSString *)fomateNumber;
//手机号码验证
- (BOOL) validateMobile;
//计算文字高度
- (CGFloat)caculateTextHeightWithSize:(CGFloat)size;
//计算文字长度
- (CGFloat)caculateTextWidthWithSize:(CGFloat)size;
//计算图片的高度（传入一个，10*20这样子的参数）
- (CGFloat)caculateToPicHeight;

/**
 *是否为空字符串
 */
- (BOOL)isBlankString;

/**
 *  验证身份证号
 *
 */
+(BOOL)validateIdCard:(NSString *)idCard;

//距离计算，M,KM
- (NSString *)distanceString;

//修改个别字体颜色,大小
- (NSMutableAttributedString *)changeTextColorWithFontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;
//时间戳转换时间
- (NSString *)changeToDateWithDateFormatter:(NSString *)dateFormat;
//时间转换时间戳
- (NSString *)changeToStamp;
//随机数
- (NSString *)randomDefaultIconWithSex:(NSString *)sex;
/**
 *  计算字节
 */
- (int)countTheStrLength;
/**
 *  判断非法输入(汉字,字母,数字)
 */

- (BOOL)validateString;
/**
 *  判断非法输入(emoji表情)
 */
- (BOOL)isContainsEmoji;

/**
 *  判断非法输入(n位小数点,negative是否允许负数)
 */

- (BOOL)validateMoneyWithN:(NSInteger)number negative:(BOOL)negative;


/**
 *  判断非法输入(数字,字母)
 */
- (BOOL)validatePSW;
/**
 *  处理price /100
 */
- (NSString *)priceString;

- (CGFloat)fitHeight;
- (CGFloat)fitWidth;
- (CGFloat)fitFont;

/**
 *  预计用时
 */
- (NSString *)cycleString;
/**
 *  计时时间
 */
- (NSString *)timeCountString;

/**
 *  转中文数字
 */
-(NSString *)translationWithALBNum;

/**
 *  计算这个月属于第几周
 */
- (NSString *)getThisMonthWhatWeekWithDate;

/**
 *  计算这个日期在第几个月
 */
- (NSString *)getThisDateMonthWithDate;

/**
 *  imageURL 转 UTF8  解决带汉字URL问题
 */
-(NSString *)imageURLToUTF8;

/**
 *  字体间距调节
 */
-(NSMutableAttributedString *)changeLabelSpacingWithFloat:(CGFloat )spacingFloat;


/**
 *  文件上传又拍云格式
 */
+ (NSString *)getImagePathWithPhone:(NSString *)phone isUserPhone:(BOOL)isPhone;
+ (NSString *)getRecordPath;
+ (NSString *)getCameraRecordPath;

/**
 *  时间多少秒前
 */
+ (NSString *)getTime:(NSString *)timeSource;

/**
 *  数字加逗号
 */
+ (NSString *)countNumAndChangeformat:(NSString *)num;

/**
 *  根据文字字数计算文本高度
 */
- (CGFloat)calculateLabelHeightWithLabelWidth:(CGFloat)width andWordSize:(CGFloat)wordSize;

/*
   排行榜根据性别和级别获取图片名字
 */
+ (NSString *)getRankImageBuyGender:(NSString *)genderString andLevel:(NSString *)levelString isBotton:(BOOL)isBotton;

//判断当前设备是否ipad
+ (BOOL)getIsIpad;

//计算多小分钟时间
- (NSString *) compareCurrentTime;
//判断字符串是否为空
+ (BOOL)isEmpty:(NSString *)str;
//我的name 和金额
+ (NSAttributedString *)LilacToolCallThodsName:(NSString *)name  OtherString:(NSString *)other;






@end

