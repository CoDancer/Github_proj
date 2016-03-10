//
//  UIHelper.m
//  BYHelperCode
//
//  Created by CoDancer on 15/9/5.
//  Copyright (c) 2015年 CoDancer. All rights reserved.
//

#import "UIHelper.h"
#import "UIImageView+WebCache.h"


@implementation UIHelper


+ (UIBarButtonItem *)navBackBarBtn:(NSString *)title target:(id)target action:(SEL)action
{
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    customBtn.frame = CGRectMake(0, 0, 21, 21);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        customBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
#endif
    [customBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
    
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    return item;
}

+ (MBProgressHUD*)showAutoHideErrorHUDforView:(UIView*)view error:(NSError*)error defaultNotice:(NSString*)defaultNotice {
    if (!view) {
        return nil;
    }
    if (error) {
        NSString *string = error.userInfo[@"error"];
        if (!string) {
            string = defaultNotice;
        }
        return [UIHelper showAutoHideHUDforView:view title:string subTitle:nil];
    } else {
        [UIHelper hideAllHUDsForView:view animated:YES];
    }
    return nil;
}
+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle {
    return [self showAutoHideHUDforView:view title:title subTitle:subTitle completeBlock:nil];
}
+ (MBProgressHUD*)showAutoHideHUDforView:(UIView*)view title:(NSString*)title subTitle:(NSString*)subTitle completeBlock:(void (^)(void))completion {
    if (!view) {
        return nil;
    }
    [self hideAllHUDsForView:view animated:NO];
    [self hideAllMBProgressHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (completion) {
        hud.completionBlock = completion;
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    if (subTitle)
    {
        hud.detailsLabelText = subTitle;
    }
    
    [hud hide:YES afterDelay:1.0f];
    return hud;
}
+ (void)hideAllHUDsForView:(UIView*)view animated:(BOOL)animated {
    [self hideAllMBProgressHUDsForView:view animated:animated];
}
+ (void)hideAllMBProgressHUDsForView:(UIView*)view animated:(BOOL)animated {
    if (!view) {
        return;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}
+ (MBProgressHUD*)showHUDAddedTo:(UIView*)view animated:(BOOL)animated {
    return [self showMBProgressHUDAddedTo:view animated:animated];
}
+ (MBProgressHUD*)showMBProgressHUDAddedTo:(UIView*)view animated:(BOOL)animated {
    if (!view) {
        return nil;
    }
    [self hideAllMBProgressHUDsForView:view animated:NO];
    return [MBProgressHUD showHUDAddedTo:view animated:animated];
}

+ (UIButton *)commomButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font selectedImage:(UIImage*)selectedImage image:(UIImage*)image {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setImage:image forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

+ (CGSize)getAppropriateImageSizeWithSize:(CGSize)size {
    
    CGSize getSize = CGSizeZero;
    CGFloat scale;
    if (size.width >= SCREEN_WIDTH) {
        getSize.width = SCREEN_WIDTH;
        scale = SCREEN_WIDTH/size.width;
        getSize.height = size.height * scale;
    }else {
        getSize = size;
    }
    return getSize;
}


@end
