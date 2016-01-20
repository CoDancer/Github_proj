//
//  BYNetErrorHUD.h
//  BYHelperCode
//
//  Created by onwer on 15/10/20.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYNetErrorHUD : UIView

+ (instancetype)showInView:(UIView *)view title:(NSString *)title completion:(void (^)(void))completion;

@end
