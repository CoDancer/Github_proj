//
//  BYNetErrorHUD.m
//  BYHelperCode
//
//  Created by onwer on 15/10/20.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "BYNetErrorHUD.h"

#define MULTILINE_TEXTSIZE(text, font, maxSize, mode) ({CGSize size = [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size; \
CGSizeMake(ceilf(size.width), ceilf(size.height));})

@implementation BYNetErrorHUD

+ (instancetype)showInView:(UIView *)view title:(NSString *)title completion:(void (^)(void))completion{
    if (view == nil) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    BYNetErrorHUD *hud = [[BYNetErrorHUD alloc] initWithTitle:title];
    hud.center = view.center;
    [view addSubview:hud];
    [UIView animateWithDuration:0.1 animations:^{
        hud.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:1.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            hud.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }];
    return hud;
    
}
- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        if (title.length > 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip_error_bg"]];
            self.frame = imageView.bounds;
            [self addSubview:imageView];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = title;
            titleLabel.font = [UIFont systemFontOfSize:14.0f];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 2;
            titleLabel.backgroundColor = [UIColor clearColor];
            CGSize textSize = MULTILINE_TEXTSIZE(title, titleLabel.font, CGSizeMake(100.0, 34.0), titleLabel.lineBreakMode);
            titleLabel.bounds = CGRectMake(0.0, 0.0, textSize.width, textSize.height);
            titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), textSize.height / 2.0 + 78.0);
            [self addSubview:titleLabel];
        }
        
    }
    return self;
}

@end
