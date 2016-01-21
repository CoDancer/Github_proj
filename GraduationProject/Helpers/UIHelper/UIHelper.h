//
//  UIHelper.h
//  BYHelperCode
//
//  Created by CoDancer on 15/9/5.
//  Copyright (c) 2015年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIHelper : NSObject


+ (UIBarButtonItem *)navBackBarBtn:(NSString *)title target:(id)target action:(SEL)action;

+ (MBProgressHUD*)showAutoHideErrorHUDforView:(UIView*)view error:(NSError*)error defaultNotice:(NSString*)defaultNotice;
+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle;

+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle completeBlock:(void (^)(void))completion;

+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated;

+ (void)hideAllMBProgressHUDsForView:(UIView*)view animated:(BOOL)animated;

+ (UIButton *)commomButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font selectedImage:(UIImage*)selectedImage image:(UIImage*)image;

+ (CGSize)getAppropriateImageSizeWithSize:(CGSize)size;

@end
