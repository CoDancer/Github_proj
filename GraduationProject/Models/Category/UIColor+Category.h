//
//  UIColor+Category.h
//  BYHelperCode
//
//  Created by onwer on 15/10/21.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
