//
//  MXBaseViewController.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/9.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXBaseViewController : UIViewController
- (UIButton *)BackBarButtonItemWithTitle:(NSString *)title;
- (UIButton *)barButtonItemName:(NSString *)name withImageName:(NSString *)imageName targer:(NSString *)targerName isRight:(BOOL)right;

- (void)SetNavigationClear;
- (void)PartnerUseThisSetNavigationGradientBackImage;
- (void)NavigationItemBack;
@end
