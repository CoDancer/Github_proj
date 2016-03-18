//
//  JGActionSheet+GPAddition.m
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "JGActionSheet+GPAddition.h"

@implementation JGActionSheet (GPAddition)

+ (instancetype)showActionSheetWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionBlock:(BFMActionSheetBlock)block {
    
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:title message:title.length ? @" " : nil buttonTitles:buttonTitles buttonStyle:JGActionSheetButtonStyleDefault];
    section1.titleLabel.textColor = [UIColor lightGrayColor];
    section1.titleLabel.font = [UIFont systemFontOfSize:13.0];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleCancel];
    NSArray *sections = @[section1, cancelSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            if (block) block(sheet, indexPath.row);
        }
        [sheet dismissAnimated:YES];
    }];
    [sheet setOutsidePressBlock:^(JGActionSheet *sheet) {
        [sheet dismissAnimated:YES];
    }];
    [sheet showInView:[UIApplication sharedApplication].keyWindow animated:YES];
    // 样式配置
    void (^configureButton)(UIButton *) = ^(UIButton *button) {
        CGFloat originalCenterY = button.center.y;
        button.width += 10.0;
        button.height += 5.0;
        button.center = CGPointMake(section1.width / 2.0, originalCenterY);
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.cornerRadius = 0;
        button.layer.borderWidth = 0.0;
    };
    if (title.length) {
        section1.titleLabel.center = CGPointMake(section1.titleLabel.center.x, section1.messageLabel.top - 4.0);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, section1.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        lineView.center = CGPointMake(section1.titleLabel.center.x , section1.messageLabel.bottom + 3.0);
        [section1 addSubview:lineView];
    }
    for (UIButton *button in section1.buttons) {
        configureButton(button);
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        if (button != section1.buttons.lastObject) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, section1.width, 0.5)];
            lineView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
            lineView.center = CGPointMake(button.center.x, button.bottom + 1.0);
            [section1 addSubview:lineView];
        }
    }
    for (UIButton *button in cancelSection.buttons) {
        configureButton(button);
        [button setTitleColor:MainColor forState:UIControlStateNormal];
    }
    return sheet;
}


@end
