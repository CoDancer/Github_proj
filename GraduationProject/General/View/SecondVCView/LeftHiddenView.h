//
//  LeftHiddenView.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftHiddenViewDelegate <NSObject>

- (void)choiceAddressBtnDidTapWithButton:(UIButton *)button;
- (void)mainViewBtnOrFoundBtnDidTapWithButton:(UIButton *)button;
- (void)userLogBtn:(UIButton *)button;

@end

@interface LeftHiddenView : UIView

@property (nonatomic, weak) id<LeftHiddenViewDelegate> hideViewDelegate;
@property (nonatomic, assign) BOOL isAllUnselected;
@property (nonatomic, assign) BOOL isUserLogin;

@end
