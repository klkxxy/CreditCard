//
//  MXTimingPushViewController.m
//  CreditCard
//
//  Created by 公司电脑 on 2019/1/18.
//  Copyright © 2019年 王启颖. All rights reserved.
//

#import "MXTimingPushViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "LYSDatePickerController.h"
#import "MXAccount.h"
#import "CreditCard.h"

@interface MXTimingPushViewController ()<LYSDatePickerSelectDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *isTimingPush;

@end

@implementation MXTimingPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSString *token = [MXAccount sharedMXAccount].token;
    [[MXAccount sharedMXAccount] LoadIsTimingPushFromSandbox];
    BOOL isTimingPush = [MXAccount sharedMXAccount].isTimingPush;
    [self.isTimingPush setOn:isTimingPush];
    
    self.title = @"设置";
}

-(void)selectTimePicker{
    LYSDatePickerController *datePicker = [[LYSDatePickerController alloc] init];
    datePicker.headerView.backgroundColor = [UIColor colorWithRed:84/255.0 green:150/255.0 blue:242/255.0 alpha:1];
    datePicker.indicatorHeight = 5;
    datePicker.delegate = self;
    datePicker.headerView.centerItem.textColor = [UIColor whiteColor];
    datePicker.headerView.leftItem.textColor = [UIColor whiteColor];
    datePicker.headerView.rightItem.textColor = [UIColor whiteColor];
    datePicker.pickHeaderHeight = 40;
    datePicker.pickType = LYSDatePickerTypeTime;
    datePicker.minuteLoop = YES;
    datePicker.headerView.showTimeLabel = NO;
    datePicker.weakDayType = LYSDatePickerWeakDayTypeUSDefault;
    datePicker.showWeakDay = YES;
    [datePicker setDidSelectDatePicker:^(NSDate *date) {

        [self removeLocalNotification];
        
        for (int i = 0; i < 30; i++) {
            NSDate *dd = [NSDate dateWithTimeInterval:i * 24*60*60 sinceDate:date];
            
            NSDateFormatter *dateFormat_HH = [[NSDateFormatter alloc] init];
            [dateFormat_HH setDateFormat:@"HH"];
            NSDateFormatter *dateFormat_mm = [[NSDateFormatter alloc] init];
            [dateFormat_mm setDateFormat:@"mm"];
            NSDateFormatter *dateFormat_yy = [[NSDateFormatter alloc] init];
            [dateFormat_yy setDateFormat:@"yyyy"];
            NSDateFormatter *dateFormat_MM = [[NSDateFormatter alloc] init];
            [dateFormat_MM setDateFormat:@"MM"];
            NSDateFormatter *dateFormat_dd = [[NSDateFormatter alloc] init];
            [dateFormat_dd setDateFormat:@"dd"];
            
            NSString *currentDate_HH = [dateFormat_HH stringFromDate:dd];
            NSString *currentDate_mm = [dateFormat_mm stringFromDate:dd];
            NSString *currentDate_yy = [dateFormat_yy stringFromDate:dd];
            NSString *currentDate_MM = [dateFormat_MM stringFromDate:dd];
            NSString *currentDate_dd = [dateFormat_dd stringFromDate:dd];

            NSDateComponents *dateCom = [[NSDateComponents alloc]init];
            dateCom.year = [currentDate_yy integerValue];
            dateCom.month = [currentDate_MM integerValue];
            dateCom.day = [currentDate_dd integerValue];
            NSDictionary *dic = [MXBankDataTool getBestCard:dateCom];
            NSArray *bestCardArr = dic[@"bestCardArr"];
            NSNumber *mianxi = dic[@"mianxi"];
            
            if (bestCardArr.count == 0) {
                [SVProgressHUD showImage:NULL_IMAGE status:@"请先添加信用卡"];
                return;
            }
            
            NSMutableString *wordBody = [[NSMutableString alloc]init];
            [wordBody appendString:@"今日推荐使用："];
            for (CreditCard *bestCard in bestCardArr) {
                [wordBody appendString:[NSString stringWithFormat:@"%@ ",bestCard.bank_name]];
            }
            [wordBody appendString:[NSString stringWithFormat:@",免息日尽高达%@天",mianxi]];

            [self scheduleLocalNotification:[currentDate_HH integerValue] andMinute:[currentDate_mm integerValue] andYear:[currentDate_yy integerValue] AndMonth:[currentDate_MM integerValue] AndDay:[currentDate_dd integerValue] andWordbody:wordBody];
        }

        [SVProgressHUD showImage:NULL_IMAGE status:@"每日定时开启成功"];
        [MXAccount sharedMXAccount].isTimingPush = YES;
        [[MXAccount sharedMXAccount] SaveIsTimingPushToSandbox];
        self.isTimingPush.on = YES;

    }];
    [datePicker showDatePickerWithController:self];
}

- (IBAction)switchTapped:(id)sender {
    UISwitch *switcher = (UISwitch *)sender;
    
    if (switcher.on) {
        switcher.on = NO;
        [self selectTimePicker];
        return;
    }
    [[MXAccount sharedMXAccount] LoadIsTimingPushFromSandbox];
    BOOL isTimingPush = [MXAccount sharedMXAccount].isTimingPush;
    if (isTimingPush) {
        [SVProgressHUD showImage:NULL_IMAGE status:@"每日定时关闭成功"];
    }
    [self removeLocalNotification];
    [MXAccount sharedMXAccount].isTimingPush = switcher.on;
    [[MXAccount sharedMXAccount] SaveIsTimingPushToSandbox];
}

- (void)scheduleLocalNotification:(NSInteger)hour andMinute:(NSInteger)minute andYear:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day andWordbody:(NSString *)wordBody {
    // 10系统以上
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        // 1.设置触发条件
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = year;
        components.month = month;
        components.day = day;
        
        components.hour = hour;
        components.minute = minute;
        UNCalendarNotificationTrigger *timeTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];

        // 2.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.body = wordBody;
        content.sound = [UNNotificationSound defaultSound];
        NSString *detail = @"其实他是假小明";
        content.userInfo = @{
                             @"detail":detail
                             };
        // 3.通知标识
        NSString *requestIdentifier = [NSString stringWithFormat:@"%ld-%ld-%ld %ld/%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute];
        // 4.创建通知请求，将1，2，3添加到请求中
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
        // 5.将通知请求添加到通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
            if (!error)
            {
                NSLog(@"推送已经添加成功");
            }
        }];
    } else { // iOS10以下
        [SVProgressHUD showImage:NULL_IMAGE status:@"不支持iOS10.0以下的设备"];
    }
}

- (void)removeLocalNotification {
    
    
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    [app cancelAllLocalNotifications];
}


@end
