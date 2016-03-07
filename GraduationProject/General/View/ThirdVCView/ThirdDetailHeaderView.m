//
//  ThirdDetailHeaderView.m
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ThirdDetailHeaderView.h"

@interface ThirdDetailHeaderView()

@property (nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIView *introBaseView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *kindsLabel;


@end

@implementation ThirdDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.baseImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        [self.introBaseView addSubview:self.introLabel];
        [self addSubview:self.introBaseView];
        [self addSubview:self.lineLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.kindsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.baseImageView.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH - 70);
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = SCREEN_WIDTH/2.0;
    self.titleLabel.top = 5;
    
    self.imageView.size = CGSizeMake(160, 160);
    self.imageView.top = self.titleLabel.bottom + 5;
    self.imageView.centerX = self.titleLabel.centerX;
    self.imageView.layer.cornerRadius = self.imageView.width/2.0;
    self.imageView.clipsToBounds = YES;
    
    [self.introLabel sizeToFit];
    
    self.introBaseView.size = CGSizeMake(self.introLabel.width + 30, 30);
    self.introBaseView.top = self.imageView.bottom + 5;
    self.introBaseView.centerX = self.titleLabel.centerX;
    self.introBaseView.layer.cornerRadius = self.introBaseView.height/2.0;
    
    self.introLabel.centerX = self.introBaseView.width/2.0;
    self.introLabel.centerY = self.introBaseView.height/2.0;
    
    [self.lineLabel sizeToFit];
    self.lineLabel.top = self.introBaseView.bottom;
    self.lineLabel.centerX = self.titleLabel.centerX;
    
    [self.numberLabel sizeToFit];
    self.numberLabel.left = 40 * k_IOS_Scale;
    self.numberLabel.bottom = self.bottom - 5;
    
    [self.kindsLabel sizeToFit];
    self.kindsLabel.left = self.numberLabel.right + 80 * k_IOS_Scale;
    self.kindsLabel.top = self.numberLabel.top;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UIImageView *)baseImageView {
    
    if (!_baseImageView) {
        _baseImageView = [UIImageView new];
    }
    return _baseImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    return _titleLabel;
}

- (UILabel *)introLabel {
    
    if (!_introLabel) {
        _introLabel = [UILabel new];
        _introLabel.textColor = [UIColor whiteColor];
        _introLabel.textAlignment = NSTextAlignmentCenter;
        _introLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _introLabel;
}

- (UIView *)introBaseView {
    
    if (!_introBaseView) {
        _introBaseView = [UIView new];
        _introBaseView.backgroundColor = MainColor;
    }
    return _introBaseView;
}

- (UILabel *)numberLabel {
    
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _numberLabel;
}

- (UILabel *)lineLabel {
    
    if (!_lineLabel) {
        _lineLabel = [UILabel new];
        _lineLabel.textColor = [UIColor blackColor];
        _lineLabel.textAlignment = NSTextAlignmentCenter;
        _lineLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _lineLabel;
}

- (UILabel *)kindsLabel {
    
    if (!_kindsLabel) {
        _kindsLabel = [UILabel new];
        _kindsLabel.textColor = [UIColor blackColor];
        _kindsLabel.textAlignment = NSTextAlignmentCenter;
        _kindsLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _kindsLabel;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    [self.baseImageView setImage:[UIImage blurryImage:[UIImage imageNamed:@"baseImg.jpg"] withBlurLevel:0.1]];
    self.titleLabel.text = @"美食食材";
    self.imageView.image = image;
    self.introLabel.text = @"美食图";
    self.lineLabel.text = @"✦✦✦✦✦✦✦✦✦✦✦✦✦";
    self.numberLabel.text = @"数量";
    self.kindsLabel.text = @"食材";
}

@end
