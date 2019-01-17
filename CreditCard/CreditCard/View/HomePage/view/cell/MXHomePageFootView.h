//
//  MXHomePageFootView.h
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXHomePageFootView : UIView

@property (nonatomic ,copy) void (^footBlock)(void);

+ (instancetype)initMXHomePageFootView;

@end

NS_ASSUME_NONNULL_END
