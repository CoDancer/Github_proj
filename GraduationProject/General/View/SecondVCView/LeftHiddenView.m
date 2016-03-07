//
//  LeftHiddenView.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/2.
//  Copyright © 2016年 onwer. All rights reserved.
//

#define GlobalColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//背景的灰色
#define BackgroundGrayColor GlobalColor(41, 42, 43)

#import "LeftHiddenView.h"
#import "UIHelper.h"
#import "UIView+Category.h"

@interface LeftHiddenView()

@property (nonatomic, strong) UIButton *choiceAddressBtn;
@property (nonatomic, strong) UIButton *recoverBtn;
@property (nonatomic, strong) UIButton *mainViewBtn;
@property (nonatomic, strong) UIButton *foundViewBtn;

@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UILabel *fastLoginLabel;
@property (nonatomic, strong) UIImageView *userLogoImageView;
@property (nonatomic, strong) UIButton *userLoginState;
@property (nonatomic, strong) UIButton *logout;

@end

@implementation LeftHiddenView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BackgroundGrayColor;
        [self addSubview:self.choiceAddressBtn];
        [self addSubview:self.mainViewBtn];
        [self addSubview:self.foundViewBtn];
        [self addSubview:self.lineImageView];
        
        [self addSubview:self.fastLoginLabel];
        [self addSubview:self.userLogoImageView];
        [self addSubview:self.userLoginState];
        [self addSubview:self.logout];
    }
    return self;
}

- (UIButton *)choiceAddressBtn {
    
    if (!_choiceAddressBtn) {
        _choiceAddressBtn = [UIHelper commomButtonWithFrame:CGRectZero title:@"请选择"
                                                 titleColor:[UIColor lightGrayColor]
                                                  titleFont:[UIFont systemFontOfSize:18.0f]
                                              selectedImage:[UIImage imageNamed:@"selectedAddress"]
                                                      image:[UIImage imageNamed:@"index_address_icon_6P"]];
        [_choiceAddressBtn setTitleColor:MainColor forState:UIControlStateSelected];
        [_choiceAddressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 30)];
        [_choiceAddressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 5)];
        [_choiceAddressBtn setBackgroundColor:[UIColor blackColor]];
        _choiceAddressBtn.layer.cornerRadius = 8.0f;
        _choiceAddressBtn.clipsToBounds = YES;
        [_choiceAddressBtn addTarget:self action:@selector(choiceAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choiceAddressBtn;
}

- (UIButton *)mainViewBtn {
    
    if (!_mainViewBtn) {
        _mainViewBtn = [UIHelper commomButtonWithFrame:CGRectZero
                                                 title:nil
                                            titleColor:nil
                                             titleFont:nil
                                         selectedImage:[UIImage imageNamed:@"homeSeletced@2x"]
                                                 image:[UIImage imageNamed:@"home@2x"]];
        [_mainViewBtn addTarget:self action:@selector(mainBtnOrFoundBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainViewBtn;
}

- (UIButton *)foundViewBtn {
    
    if (!_foundViewBtn) {
        _foundViewBtn = [UIHelper commomButtonWithFrame:CGRectZero
                                                  title:nil
                                             titleColor:nil
                                              titleFont:nil
                                          selectedImage:[UIImage imageNamed:@"foundSelected@2x"]
                                                  image:[UIImage imageNamed:@"found@2x"]];
        [_foundViewBtn addTarget:self action:@selector(mainBtnOrFoundBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foundViewBtn;
}

- (UIButton *)recoverBtn {
    
    if (!_recoverBtn) {
        _recoverBtn = [UIButton new];
        [_recoverBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_recoverBtn addTarget:self action:@selector(recoverBtnDidTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recoverBtn;
}

- (UIImageView *)lineImageView {
    
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor blackColor];
        _lineImageView.alpha = 0.2;
    }
    return _lineImageView;
}

- (UILabel *)fastLoginLabel {
    
    if (!_fastLoginLabel) {
        _fastLoginLabel = [UILabel new];
        _fastLoginLabel.text = @"快速登录";
        _fastLoginLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _fastLoginLabel.textColor = [UIColor lightGrayColor];
    }
    return _fastLoginLabel;
}

- (UIImageView *)userLogoImageView {
    
    if (!_userLogoImageView) {
        _userLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        _userLogoImageView.layer.cornerRadius = _userLogoImageView.height/2.0;
        _userLogoImageView.clipsToBounds = YES;
        _userLogoImageView.image = [UIImage imageNamed:@"mine_avatarDetail"];
    }
    return _userLogoImageView;
}

- (UIButton *)userLoginState {
    
    if (!_userLoginState) {
        _userLoginState = [UIButton new];
        [_userLoginState setTitle:@"未登录" forState:UIControlStateNormal];
        _userLoginState.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_userLoginState addTarget:self action:@selector(userLogBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _userLoginState.layer.cornerRadius = 4.0;
        _userLoginState.layer.borderWidth = 1.0f;
        _userLoginState.layer.borderColor = MainColor.CGColor;
    }
    return _userLoginState;
}

- (UIButton *)logout {
    
    if (!_logout) {
        _logout = [UIButton new];
        [_logout setTitle:@"注销" forState:UIControlStateNormal];
        _logout.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_logout addTarget:self action:@selector(userLogBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _logout.layer.cornerRadius = 4.0;
        _logout.layer.borderWidth = 1.0f;
        _logout.layer.borderColor = MainColor.CGColor;
    }
    return _logout;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.choiceAddressBtn.frame = CGRectMake(35, 50, 180, 40);
    
    self.mainViewBtn.left = self.choiceAddressBtn.left;
    self.mainViewBtn.top = self.choiceAddressBtn.bottom + 40;
    self.mainViewBtn.size = CGSizeMake(190, 55);
    
    self.foundViewBtn.left = self.mainViewBtn.left;
    self.foundViewBtn.top = self.mainViewBtn.bottom + 10;
    self.foundViewBtn.size = self.mainViewBtn.size;
    
    self.lineImageView.top = self.foundViewBtn.bottom + 40;
    self.lineImageView.left = 25;
    self.lineImageView.width = self.choiceAddressBtn.width + 20;
    self.lineImageView.height = 1.0f;
    
    [self.fastLoginLabel sizeToFit];
    self.fastLoginLabel.left = self.lineImageView.left;
    self.fastLoginLabel.top = self.lineImageView.bottom + 10;
    
    self.userLogoImageView.left = self.fastLoginLabel.left;
    self.userLogoImageView.top = self.fastLoginLabel.bottom + 50;
    
    self.userLoginState.size = CGSizeMake(100, 30);
    self.userLoginState.left = self.userLogoImageView.right + 20;
    self.userLoginState.bottom = self.userLogoImageView.centerY - 5;
    
    self.logout.size = CGSizeMake(100, 30);
    self.logout.left = self.userLoginState.left;
    self.logout.top = self.userLogoImageView.centerY + 5;
}

- (void)choiceAddress {
    if ([self.hideViewDelegate respondsToSelector:@selector(choiceAddressBtnDidTapWithButton:)]) {
        [self.hideViewDelegate choiceAddressBtnDidTapWithButton:self.choiceAddressBtn];
    }
}

- (void)userLogBtnDidTap:(UIButton *)sender {
    
    
}

- (void)recoverBtnDidTap {
    
}

- (void)mainBtnOrFoundBtnDidTap:(UIButton *)sender {
    
    if ([self.hideViewDelegate respondsToSelector:@selector(mainViewBtnOrFoundBtnDidTapWithButton:)]) {
        [self.hideViewDelegate mainViewBtnOrFoundBtnDidTapWithButton:sender];
    }
}

@end
