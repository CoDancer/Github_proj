//
//  UIViewController+TXAddition.m
//  BYHelperCode
//
//  Created by onwer on 15/10/20.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "UIViewController+TXAddition.h"
#import "BYNetErrorHUD.h"
#import <objc/runtime.h>

static char networkHUDKey;

@implementation UIViewController (TXAddition)

- (void)dismissLoadingHUDWithFailureText:(NSString *)text{
    [self showNetworkErrorHUDWithText:text];
}
- (void)showNetworkErrorHUDWithText:(NSString *)text{
    UIView *view = self.navigationController.view ? :self.view;
    self.networkHUD = [BYNetErrorHUD showInView:view title:text completion:^{
        self.networkHUD = nil;
    }];
}
- (void)setNetworkHUD:(BYNetErrorHUD *)networkHUD
{
    objc_setAssociatedObject(self, &networkHUDKey, networkHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BYNetErrorHUD *)networkHUD{
    BYNetErrorHUD *hud = objc_getAssociatedObject(self, &networkHUDKey);
    return hud;
}

- (void)dismissBottomView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissView" object:nil];
}

- (void)showBottomView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowView" object:nil];
}

@end
