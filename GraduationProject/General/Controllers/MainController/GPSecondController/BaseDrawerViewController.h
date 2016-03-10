//
//  BaseDrawerViewController.h
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftHiddenView.h"

@interface BaseDrawerViewController : UIViewController

@property (nonatomic, strong) LeftHiddenView *hiddenView;

- (void)configView;
- (UIView *)getCustomNaviView;

@end
