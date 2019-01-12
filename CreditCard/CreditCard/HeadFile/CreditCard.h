//
//  CatchBear.h
//  CatchBear
//
//  Created by CatchBear on 2018/6/4.
//  Copyright © 2018年 CatchBear. All rights reserved.
//

#ifndef CatchBear_h
#define CatchBear_h


#define CHANNEL @"ios"

#define isIOS11 [[UIDevice currentDevice].systemVersion floatValue] >= 11
// 版本
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

#define FONTSIZE(size) [UIFont systemFontOfSize:size]


#define APP_SPACE(float) [LYGlobalDefine getScreenScale:float]
// 高度
#define kTabBarViewHeight 49
#define kStatusNavigationHeight (kSystemVersion >= 7.0 ? 64 : 0)
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenSize  [[UIScreen mainScreen] bounds].size
#define kBannerHeight 120
#define KISIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KSafeAreaTopHeight (KISIPhoneX ? 88 : 64)
#define KSafeAreaBottonHeight (KISIPhoneX ? 34 : 0)

#define NSbunleloadNibName(nibName) [[[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil] lastObject]
#define NSNotificationCenter_defaultCenter [NSNotificationCenter defaultCenter]
#define RightButtonItem(imageName,highimage)  self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightAction) image:imageName highImage:highimage];

#define APP_SPACE(float) [LYGlobalDefine getScreenScale:float]
#define WEAK_SELF(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define STRONG_SELF(strongSelf) __strong __typeof(&*weakSelf) strongSelf = weakSelf;

#define kWidthRatio         (kScreenWidth/375.0f)
#define kHeightRatio        1//kHeightRatio()
#define PCChat_USERDEFAUT [NSUserDefaults standardUserDefaults]

#define USER_DEAFAUTAVATAR    [UIImage imageNamed:@"userDefaultAvatar"]
#define PCHAT_DEAFAUTPHOTOIMAGE  [UIImage imageNamed:@"photoAndVideoDefault"]
#define DEAFAUTIMAGE     [UIImage imageNamed:@""] //这里后面使用
#define NULL_IMAGE [UIImage imageNamed:@""]
#define PCCCHAT_WEIXIN_NUMBER @"PCChatWeixinNumber"
#define PCCCHAT_QQ_NUMBER @"PCChatQQNumber"
#define PCCHATHOME_NAVITABBAR @"PCCahtHome_tabbar"
#define PCCHATPrivacy_url @"http://m3.leadnewnet.com/index.php?m=about_blagreement"

//云信使用
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define UIScreenWidth                              [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight                             [UIScreen mainScreen].bounds.size.height
#define UISreenWidthScale   UIScreenWidth / 320
#define UICommonTableBkgColor UIColorFromRGB(0xe4e7ec)
#define Message_Font_Size   14        // 普通聊天文字大小
#define Notification_Font_Size   10   // 通知文字大小
#define Chatroom_Message_Font_Size 16 // 聊天室聊天文字大小









#endif /* CatchBear_h */
