//
//  NaviView.m
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NaviView.h"

@interface NaviView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation NaviView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.backBtn];
        [self addSubview:self.upBtn];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.backBtn sizeToFit];
    self.backBtn.left = 10;
    self.backBtn.centerY = 42;
    self.upBtn.size = CGSizeMake(50, 30);
    self.upBtn.left = 0;
    self.upBtn.centerY = 42;
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.centerY = self.backBtn.centerY;
    self.lineView.size = CGSizeMake(SCREEN_WIDTH, 1.0);
    self.lineView.bottom = self.height;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIButton *)upBtn {
    
    if (!_upBtn) {
        _upBtn = [UIButton new];
        [_upBtn addTarget:self action:@selector(popLastVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upBtn;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = COLOR_LINE;
    }
    return _lineView;
}

- (void)popLastVC {
    
    __weak typeof(self) weakself = self;
    if (self.backBlock) {
        weakself.backBlock();
    }
}

- (void)setBGColor:(UIColor *)BGColor {
    
    _BGColor = BGColor;
    self.backgroundColor = BGColor;
}

- (void)setText:(NSString *)text {
    
    _text = text;
    self.titleLabel.text = text;
}

@end
