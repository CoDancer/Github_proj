//
//  UIViewController+TXAddition.h
//  BYHelperCode
//
//  Created by onwer on 15/10/20.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TXAddition)

- (void)dismissLoadingHUDWithFailureText:(NSString *)text;

- (void)dismissBottomView;

- (void)showBottomView;

@end
