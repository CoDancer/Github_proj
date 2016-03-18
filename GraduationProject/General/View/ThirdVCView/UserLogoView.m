//
//  UserLogoView.m
//  GraduationProject
//
//  Created by onwer on 16/3/14.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "UserLogoView.h"
#import "UIImageView+WebCache.h"

@interface UserLogoView()

@property (nonatomic, strong) UIButton *leftBackBtn;
@property (nonatomic, strong) UIButton *upBackBtn;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *sexImageView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *mottoLabel;

@end

@implementation UserLogoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.leftBackBtn];
        [self addSubview:self.upBackBtn];
        [self addSubview:self.logoImageView];
        [self addSubview:self.sexImageView];
        [self addSubview:self.nickName];
        [self addSubview:self.mottoLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.leftBackBtn sizeToFit];
    self.leftBackBtn.left = 10;
    self.leftBackBtn.centerY = 42;
    self.upBackBtn.size = CGSizeMake(40, 40);
    self.upBackBtn.left = 0;
    self.upBackBtn.top = 20;
    self.bgImageView.left = 0;
    self.bgImageView.top = 0;
    self.logoImageView.top = 75;
    self.logoImageView.centerX = self.centerX;
    [self.nickName sizeToFit];
    self.nickName.top = self.logoImageView.bottom + 10;
    self.nickName.centerX = self.logoImageView.centerX;
    self.sexImageView.left = self.nickName.right + 4;
    self.sexImageView.centerY = self.nickName.centerY;
    [self.mottoLabel sizeToFit];
    self.mottoLabel.width = self.width - 40;
    self.mottoLabel.left = 20;
    self.mottoLabel.top = self.nickName.bottom + 10;
    self.mottoLabel.centerX = self.nickName.centerX;
}

- (UIButton *)leftBackBtn {
    
    if (!_leftBackBtn) {
        _leftBackBtn = [UIButton new];
        [_leftBackBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
    }
    return _leftBackBtn;
}

- (UIButton *)upBackBtn {
    
    if (!_upBackBtn) {
        _upBackBtn = [UIButton new];
        [_upBackBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upBackBtn;
}

- (UIImageView *)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        if ([UserDefaults objectForKey:@"bgImageData"] != nil) {
            UIImage *image = [UIImage imageWithData:[UserDefaults objectForKey:@"bgImageData"]];
            self.bgImageView.image = image;
        }else {
            _bgImageView.image = [UIImage imageNamed:@"bgImage.jpg"];
        }
        _bgImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        [_bgImageView addGestureRecognizer:tap];
    }
    return _bgImageView;
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _logoImageView.layer.cornerRadius = _logoImageView.height/2.0;
        _logoImageView.clipsToBounds = YES;
        if ([UserDefaults objectForKey:@"iconImg"] != nil) {
            [_logoImageView sd_setImageWithURL:[UserDefaults objectForKey:@"iconImg"] placeholderImage:[UIImage imageNamed:@"mylogo.jpg"]];
        }else {
            if ([UserDefaults objectForKey:@"logoImageData"] == nil) {
                self.logoImageView.image = [UIImage imageNamed:@"mylogo.jpg"];
            }else {
                UIImage *image = [UIImage imageWithData:[UserDefaults objectForKey:@"logoImageData"]];
                self.logoImageView.image = image;
            }
        }
        
    }
    return _logoImageView;
}

- (UIImageView *)sexImageView {
    
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        if ([UserDefaults objectForKey:@"iconImg"] != nil) {
            if ([[UserDefaults objectForKey:@"sex"] isEqualToString:@"男"]) {
                _sexImageView.image = [UIImage imageNamed:@"tag_male"];
            }else {
                _sexImageView.image = [UIImage imageNamed:@"tag_female"];
            }
        }else {
            _sexImageView.image = [UIImage imageNamed:@"tag_male"];
        }
    }
    return _sexImageView;
}

- (UILabel *)nickName {
    
    if (!_nickName) {
        _nickName = [UILabel new];
        _nickName.textColor = [UIColor blackColor];
        _nickName.font = [UIFont boldSystemFontOfSize:18.0f];
        _nickName.textAlignment = NSTextAlignmentCenter;
        if ([UserDefaults objectForKey:@"iconImg"] != nil) {
            _nickName.text = [UserDefaults objectForKey:@"nickName"];
        }else {
            if ([UserDefaults objectForKey:@"userName"] != nil) {
                _nickName.text = [UserDefaults objectForKey:@"userName"];
            }else {
                _nickName.text = @"无名君";
            }
        }
    }
    return _nickName;
}

- (UILabel *)mottoLabel {
    
    if (!_mottoLabel) {
        _mottoLabel = [UILabel new];
        _mottoLabel.textColor = [UIColor grayColor];
        _mottoLabel.font = [UIFont systemFontOfSize:14.0f];
        _mottoLabel.textAlignment = NSTextAlignmentCenter;
        if ([UserDefaults objectForKey:@"iconImg"] != nil) {
            if ([UserDefaults objectForKey:@"msg"] == nil) {
                _mottoLabel.text = @"Do Better Myself";
            }else {
                _mottoLabel.text = [UserDefaults objectForKey:@"msg"];
            }
        }else {
            if ([UserDefaults objectForKey:@"motto"] != nil) {
                _mottoLabel.text = [UserDefaults objectForKey:@"motto"];
            }else {
                _mottoLabel.text = @"Do Better Myself";
            }
        }
        _mottoLabel.numberOfLines = 2;
    }
    return _mottoLabel;
}

- (void)popVC {
    
    if(self.popBlock){
        self.popBlock();
    }
}

- (void)tapView {
    
    if (self.tapBlack) {
        self.tapBlack();
    }
}

- (void)setIsModifyInfo:(BOOL)isModifyInfo {
    
    _isModifyInfo = isModifyInfo;
    if ([UserDefaults objectForKey:@"bgImageData"] != nil) {
        UIImage *image = [UIImage imageWithData:[UserDefaults objectForKey:@"bgImageData"]];
        self.bgImageView.image = image;
    }
    if ([UserDefaults objectForKey:@"logoImageData"] != nil) {
        UIImage *image = [UIImage imageWithData:[UserDefaults objectForKey:@"logoImageData"]];
        self.logoImageView.image = image;
    }
    if ([UserDefaults objectForKey:@"userName"] != nil) {
        self.nickName.text = [UserDefaults objectForKey:@"userName"];
        [self.nickName sizeToFit];
    }
    if ([UserDefaults objectForKey:@"motto"] != nil) {
        self.mottoLabel.text = [UserDefaults objectForKey:@"motto"];
        [self.mottoLabel sizeToFit];
    }
}

@end
