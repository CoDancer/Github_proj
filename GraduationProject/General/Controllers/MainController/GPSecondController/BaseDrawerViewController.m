//
//  BaseDrawerViewController.m
//  PopViewController
//
//  Created by onwer on 15/12/28.
//  Copyright © 2015年 onwer. All rights reserved.
//

#import "BaseDrawerViewController.h"
#import "UIView+Category.h"
#import "LeftHiddenView.h"

#define GlobalColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//app的高度
#define AppWidth ([UIScreen mainScreen].bounds.size.width)
//app的宽度
#define AppHeight ([UIScreen mainScreen].bounds.size.height)

@interface BaseDrawerViewController()<LeftHiddenViewDelegate>

@property (nonatomic, strong) UIView *baseCustomNaviView;

@end

@implementation BaseDrawerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addLeftHiddenView];
    [self configView];
}

- (void)configView {
    
}

- (UIView *)baseCustomNaviView {
    
    if (!_baseCustomNaviView) {
        _baseCustomNaviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 64)];
        _baseCustomNaviView.backgroundColor = MainColor;
        UIButton *leftBtn = [UIButton new];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"InfoDefaultIcon_6P"] forState:UIControlStateNormal];
        leftBtn.size = CGSizeMake(30, 30);
        [leftBtn addTarget:self action:@selector(showDrawerView) forControlEvents:UIControlEventTouchUpInside];
        UIButton *rightBtn = [UIButton new];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(researchRecommend) forControlEvents:UIControlEventTouchUpInside];
        
        [_baseCustomNaviView addSubview:leftBtn];
        [_baseCustomNaviView addSubview:rightBtn];
        
        leftBtn.left = 5;
        leftBtn.centerY = 42;
        
    }
    return _baseCustomNaviView;
}

- (UIView *)getCustomNaviView {
    return self.baseCustomNaviView;
}

- (void)addLeftHiddenView {
    self.hiddenView = [[LeftHiddenView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.hiddenView.hideViewDelegate = self;
    [self.view addSubview:self.hiddenView];
}

- (void)showDrawerView {
}

- (void)researchRecommend {
}

- (void)choiceAddressBtnDidTapWithButton:(UIButton *)button {
}

- (void)mainViewBtnOrFoundBtnDidTapWithButton:(UIButton *)button {
}

- (void)userLogBtn:(UIButton *)button {
}

@end
