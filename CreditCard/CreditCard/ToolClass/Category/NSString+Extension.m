//
//  NSString+Extension.m
//  ZLKNB
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 获得系统版本
    if (iOS7) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (NSString *)md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (void)clickTelephoneNumber{
    
    
    
}
//手机号码验证
- (BOOL) validateMobile
{
    //    //手机号以13， 15，18, 17开头，八个 \d 数字字符
    NSString *phoneRegex = @"0?(13|14|15|17|18)[0-9]{9}";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    /**
     
     25         * 大陆地区固话及小灵通
     
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     
     27         * 号码：七位或八位
     
     28         */
    
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    
    
    if(([phoneTest evaluateWithObject:self] == YES)
       || ([regextestphs evaluateWithObject:self] == YES))
        
    {
        return YES;
    }
    
    else
        
    {
        return NO;
    }
}

- (BOOL)checkEmail{
    
    BOOL infoRightOrNot = NO;
    if ([self length] > 4 && [self length]< 33) {
        NSString *regex = @"([\\d|a-z|A-Z|-|_|\\.])*([\\d|a-z|A-Z])+(@)+([\\d|a-z|A-Z|])*(-)*(_)*([\\d|a-z|A-Z|])+(\\.[a-z|A-Z]{2,3})*(\\.[a-z|A-Z]{2,3})";
        NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([regextest evaluateWithObject:self] == YES) {
            infoRightOrNot = YES;
        }
    }
    return infoRightOrNot;
}

/*
 **
 * 功能:验证身份证是否合法
 *
 * 参数:输入的身份证号
 */
+(BOOL)validateIdCard:(NSString *)idCard
{
    
    //判断位数
    if ([idCard length] < 15 ||[idCard length] > 18) {
        return NO;
    }
    
    NSString *carid = idCard;
    long lSumQT =0;
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:idCard];
    if ([idCard length] == 15) {
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    //判断年月日是否有效
    
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return NO;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return YES;
        }
    }
    //验证最末的校验码
    lSumQT = 0;
    for (int i=0; i<17; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}
/*
 **
 * 功能:获取指定范围的字符串
 *
 * 参数:字符串的开始下标
 *
 * 参数:字符串的结束下标
 */
+(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}


/**
 * 功能:判断是否在地区码内
 *
 * 参数:地区码
 */
+(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}


-(NSString *)base64String{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64Encoded;
}



-(NSString *)delestring{
    if ([self hasPrefix:@"./"]) {
        
        NSMutableString *afterstring = self.mutableCopy;
        [afterstring deleteCharactersInRange:NSMakeRange(0, 2)];
        return afterstring;
        
    }
    return self;
}
- (NSString *)deleThumstring{
    
    if ([self containsString:@"_thumb"]) {
        
        NSMutableString *afterstring = self.mutableCopy;
        [afterstring deleteCharactersInRange:NSMakeRange(afterstring.length-10, 6)];
        return afterstring;
        
    }
    return self;
}
-(NSString *)deleImagestring{
    if ([self hasPrefix:@"./imagines/"]) {
        
        NSMutableString *afterstring = self.mutableCopy;
        [afterstring deleteCharactersInRange:NSMakeRange(0, 11)];
        return afterstring;
        
    }
    return self;
}

- (NSString *)fomateNumber{
    if (self.length < 3)
    {
        return self;
    }
    NSString *numStr = self;
    NSArray *array = [numStr componentsSeparatedByString:@"."];
    NSString *numInt = [array objectAtIndex:0];
    if (numInt.length <= 3)
    {
        return self;
    }
    NSString *suffixStr = @"";
    if ([array count] > 1)
    {
        suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
    }
    
    NSMutableArray *numArr = [[NSMutableArray alloc] init];
    while (numInt.length > 3)
    {
        NSString *temp = [numInt substringFromIndex:numInt.length - 3];
        numInt = [numInt substringToIndex:numInt.length - 3];
        [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
    }
    NSInteger count = [numArr count];
    for (int i = 0; i < count; i++)
    {
        numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
    }
    numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
    return numStr;
}

- (CGFloat)caculateTextHeightWithSize:(CGFloat)size{
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(kScreenWidth-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
    CGFloat height = ceil(rect.size.height);
//    CGFloat height = rect.size.height;

    return height;
}
- (CGFloat)caculateTextWidthWithSize:(CGFloat)size{
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    
//    CGFloat widthl = size * [self countTheStrLength];
    
    CGFloat width = rect.size.width;
    
    return width;
}

- (CGFloat)caculateToPicHeight{
    NSArray *pic_size = [self componentsSeparatedByString:@"*"];
    CGFloat pic_width = [pic_size[0] floatValue];
    CGFloat pic_height = [pic_size[1] floatValue];
    
    if (pic_width < kScreenWidth) {
        return pic_height;
    }else{
        return kScreenWidth/pic_width*pic_height;
    }
    
}

- (NSString *)distanceString {
    NSString * distance = nil;
    if([self integerValue] >= 1000){
        if ([self integerValue] >= 1000000) {
            distance = @"  相距很远";
        }else{
            distance = [NSString stringWithFormat:@"<%.1f km",[self floatValue]/1000.0];
        }
        return distance;
    }else {
        if ([self integerValue] < 100) {
            distance = @"<100 m";
        }else {
            distance = [NSString stringWithFormat:@"<%.1f m",[self floatValue]/1.0];
        }
        return distance;
    }
}

-(NSMutableAttributedString *)changeTextColorWithFontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:
     vaColor range:range];
    return str;
}


- (BOOL) isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
-(NSString *)changeToDateWithDateFormatter:(NSString *)dateFormat{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:dateFormat];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/BeiJing"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *str = self;
    NSTimeInterval second2 = [str doubleValue];
    NSDate *date3 = [NSDate dateWithTimeIntervalSince1970:second2];
    NSString *dateString = [dateFormatter stringFromDate:date3];
    return dateString;
}
- (NSString *)changeToStamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.dateFormat = @"YYYY-MM-dd";
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate * date = [formatter dateFromString:self];
    NSString * string =[NSString stringWithFormat:@"%d",(long)[date timeIntervalSince1970]];
    return string;
}
- (NSString *)randomDefaultIconWithSex:(NSString *)sex{
    NSString * name  = nil;
    if ([sex integerValue] == 1) {
        int i = arc4random()%1+1;
        name = [NSString stringWithFormat:@"%@%d",self,i];
    }else if ([sex integerValue] == 0){
        int i = arc4random()%1+3;
        name = [NSString stringWithFormat:@"%@%d",self,i];
        
    }else {
        int i = arc4random()%3+1;
        name = [NSString stringWithFormat:@"%@%d",self,i];
    }
    return name;
}

- (int)countTheStrLength {
    
    int strlength = 0;
    int returnLength = 0;//回车键长度
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    
    NSString *str = @"\n";
    //在self这个字符串中搜索\n，判断有没有
    if ([self rangeOfString:str].location != NSNotFound) {
        NSArray *array = [self componentsSeparatedByString:str];
        returnLength = (array.count-1)*((kScreenWidth-30)/14);
    }
    //在self这个字符串中搜索"一"，因为他的字节为1,实际应为2
    NSString *str1 = @"一";
    if ([self rangeOfString:str1].location != NSNotFound) {
        NSArray *array = [self componentsSeparatedByString:str1];
        returnLength = ceilf((array.count-1)/2.0);
    }
    
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    return (strlength+1)/2+returnLength;
}
- (BOOL)validateString{
    
    NSString *validate = @"^[a-zA-Z0-9\u4e00-\u9fa5]+|$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",validate];
    
    if(([test evaluateWithObject:self] == YES)) {
        return YES;
    }
    else{
        return NO;
    }
}
//
- (BOOL)isContainsEmoji{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
- (BOOL)validateMoneyWithN:(NSInteger)number negative:(BOOL)negative{
    NSString *validate = nil;
    if (negative) {
        validate =[NSString stringWithFormat:@"^(-)?(\\d+)\\.?(\\d{0,%lu})|$",number];
    }else{
        validate =[NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})|$",number];
        
    }
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",validate];
    
    if(([test evaluateWithObject:self] == YES)) {
        return YES;
    }
    else{
        return NO;
    }
    
}

- (BOOL)validatePSW{
    
    NSString *validate = @"^[a-zA-Z0-9]+|$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",validate];
    //    NSPredicate *test1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",validate1];
    
    if(([test evaluateWithObject:self] == YES)) {
        return YES;
    }
    else{
        return NO;
    }
}

- (NSString *)priceString{
    NSString * price = nil;
    if (self.length > 2) {
        
        NSString * last2String = [self substringFromIndex:self.length-2];
        NSString * last1String = [self substringFromIndex:self.length-1];
        
        if ([last2String isEqualToString:@"00"]) {
            price = [NSString stringWithFormat:@"%d",[self integerValue]/100];
        }else if([last1String isEqualToString:@"0"]){
            price = [NSString stringWithFormat:@"%.1f",(CGFloat)[self integerValue]/100.0];
        }else{
            price = [NSString stringWithFormat:@"%.2f",(CGFloat)[self integerValue]/100.0];
        }
        
    }else{
        price = [self intValue] == 0 ? @"0":[NSString stringWithFormat:@"%.2f",(CGFloat)[self integerValue]/100.0];
    }
    return price;
}


- (CGFloat)fitHeight{
    if (kScreenWidth == 540) {
        return [self floatValue];
    }else{
        return [self floatValue]*667/960.0;
    }
}
- (CGFloat)fitWidth{
    if (kScreenWidth == 540) {
        return [self floatValue];
    }else{
        return [self floatValue]*375/540.0;
    }
    
}
- (CGFloat)fitFont{
    if (kScreenWidth == 540) {
        return [self floatValue];
    }else{
        return [self floatValue]*375/440.0;
    }
}

- (NSString *)cycleString{
    
    NSString * cycle = nil;
    
    if ([self integerValue]>=24) {
        
        if([self integerValue]%24 != 0){
            
            cycle = [NSString stringWithFormat:@"%d天%d小时",[self integerValue]/24,[self integerValue]%24];
            
        }else{
            cycle = [NSString stringWithFormat:@"%d天",[self integerValue]/24];
            
        }
    }else{
        cycle = [NSString stringWithFormat:@"%d小时",[self integerValue]];
        
    }
    
    
    return cycle.length?cycle:@"";
}
- (NSString *)timeCountString{
    
    NSInteger interval = [self integerValue];
    
    int days = (interval)/60/60/24;
    int hours=(interval-days*24*60*60)/60/60;
    int mins=(interval - days*24*60*60- hours*60*60)/60;
    int sec=(interval)%60;
    
    
    NSString * time = nil;
    
    
    if (sec > 0 && sec < 60) {
        mins = mins+1;
    }
    
    if (days == 0) {
        if (hours ==0) {
            time = [NSString stringWithFormat:@"%d分钟",mins];
        }else{
            time = [NSString stringWithFormat:@"%d小时%d分钟",hours,mins];
        }
    }else{
        time = [NSString stringWithFormat:@"%d天%d小时%d分钟",days,hours,mins];
    }
    
    return time.length?time:@"";
    
}


-(NSString *)translationWithALBNum

{   NSString *str = self;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];

    
    NSInteger monthNum = [self integerValue];
    if (monthNum == 10 || monthNum == 11 || monthNum == 12) {
        chinese = [chinese substringFromIndex:1];
    }
    
    return chinese;
}

- (NSString *)getThisMonthWhatWeekWithDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:self];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    // 周几和星期几获得
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:date];
    NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 这个月的第几周
    
    return [NSString stringWithFormat:@"%ld", weekdayOrdinal];
}

- (NSString *)getThisDateMonthWithDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateFormatter dateFromString:self];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:date];
    NSInteger month = [comps month];
    
    return [NSString stringWithFormat:@"%ld", month];
}

-(NSString *)imageURLToUTF8 {
    
    NSString *imageURL = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return imageURL;
}


-(NSMutableAttributedString *)changeLabelSpacingWithFloat:(CGFloat )spacingFloat {
    //实例化NSMutableAttributedString模型
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self];
    //建立行间距模型
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle1 setLineSpacing:spacingFloat];
    //把行间距模型加入NSMutableAttributedString模型
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self length])];
    
    return attributedString1;
}

+ (NSString *)getTime:(NSString *)timeSource {
//    //Tue Mar 08 13:14:45 +0800 2016  服务端获取时间的格式是这样的
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
//    //设置时区
    form.locale = [NSLocale localeWithLocaleIdentifier:@"cn"];
    form.dateFormat = @"EEE MMM dd HH:mm:ss Z yyy";
//    NSDate *date = [form dateFromString:timeSource];

    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeSource integerValue]];
    
    //得到当前的时间差
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //然后进行时间的比较
    if(timeInterval < 60) {
        return [NSString stringWithFormat:@"%ld秒前在线",(NSInteger)timeInterval];
    }
    //分钟
    NSInteger minute = timeInterval / 60;
    if(minute < 60) {
        return [NSString stringWithFormat:@"%ld分钟前在线",minute];
    }
    NSInteger hours = minute / 60;
    if(hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前在线",hours];
    }
    NSInteger day = hours / 24;
    if(day <= 1) {
        form.dateFormat = @"HH:mm";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"昨天 %@",oldtime];
    }
//    else if(day < 7) {
//        return [NSString stringWithFormat:@"%ld天之前",day];
//    }
    else {
        form.dateFormat = @"yyyy-MM-dd";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"%@",oldtime];
    }
    
    return nil;
}

// 每三个小数加个逗号
+(NSString *)countNumAndChangeformat:(NSString *)num {
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

- (CGFloat)calculateLabelHeightWithLabelWidth:(CGFloat)width andWordSize:(CGFloat)wordSize {
    CGSize contentSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:wordSize]} context:nil].size;
    return contentSize.height;
}
/*
 排行榜根据性别和级别获取图片名字
 */
+ (NSString *)getRankImageBuyGender:(NSString *)genderString andLevel:(NSString *)levelString isBotton:(BOOL)isBotton;
{
      NSInteger gender = [genderString integerValue];
      NSInteger level  = [levelString integerValue];
    if (level > 5) {
        level = 5;
    }
     NSString *imageName;
    if (gender == 1) {
        //男
        imageName = [NSString stringWithFormat:@"cchm_wealthLV%ld",level];
    }else
    {
        
        imageName = [NSString stringWithFormat:@"cchm_TheHostLV%ld",level];
    }
    return imageName;
    
}
//判断当前设备是否ipad
+ (BOOL)getIsIpad;
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}
- (NSString *) compareCurrentTime
{
    //把字符串转为NSdate
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval interval    = [self doubleValue];
    NSDate *timeDate               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDate *currentDate = [NSDate date];
    
    //得到两个时间差
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    } else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}
- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}
- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

+ (BOOL)isEmpty:(NSString *)str {
    if (str==nil || str == [NSNull null]) {
        return YES;
    }
    if ([str isKindOfClass:[NSString class]]) {
        return [str isEmpty];
    }
    return NO;// 非字符串
}

@end
