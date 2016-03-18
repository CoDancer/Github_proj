//
//  JGActionSheet+GPAddition.h
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "JGActionSheet.h"

@class JGActionSheet;

typedef void (^BFMActionSheetBlock)(JGActionSheet *sheet, NSUInteger index);

@interface JGActionSheet (GPAddition)

+ (instancetype)showActionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionBlock:(BFMActionSheetBlock)block;

@end
