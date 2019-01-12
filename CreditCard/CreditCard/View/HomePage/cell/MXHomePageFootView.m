//
//  MXHomePageFootView.m
//  CreditCard
//
//  Created by 王启颖 on 2019/1/9.
//  Copyright © 2019 王启颖. All rights reserved.
//

#import "MXHomePageFootView.h"
#import "MXChoiceBankController.h"

@implementation MXHomePageFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)addCreditCard:(id)sender {
    
    if (_footBlock) {
        _footBlock();
    }
    
    
}

+ (instancetype)initMXHomePageFootView {
    return NSbunleloadNibName(@"MXHomePageFootView");
}

@end
