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

#define UMENG_SDK @"5c434cf0f1f5565ffb0015f3"

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

#define WEAK_SELF(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define STRONG_SELF(strongSelf) __strong __typeof(&*weakSelf) strongSelf = weakSelf;

#define NULL_IMAGE [UIImage imageNamed:@""]











#endif /* CatchBear_h */
