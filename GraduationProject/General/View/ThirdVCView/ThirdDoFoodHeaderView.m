//
//  ThirdDoFoodHeaderView.m
//  GraduationProject
//
//  Created by onwer on 16/1/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "ThirdDoFoodHeaderView.h"

@interface ThirdDoFoodHeaderView()

@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ThirdDoFoodHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //self.alpha = 0.8;
        [self addSubview:self.introLabel];
        [self addSubview:self.logoImageView];
        [self addSubview:self.nameLabel];
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.introLabel.width = SCREEN_WIDTH - 30 * 2;
    self.introLabel.height = 50;
    self.introLabel.top = 5;
    self.introLabel.centerX = self.centerX;
    
    self.logoImageView.size = CGSizeMake(60, 60);
    self.logoImageView.top = self.introLabel.bottom + 5;
    self.logoImageView.centerX = self.centerX;
    self.logoImageView.layer.cornerRadius = 30;
    self.logoImageView.clipsToBounds = YES;
    
    [self.nameLabel sizeToFit];
    self.nameLabel.top = self.logoImageView.bottom + 5;
    self.nameLabel.centerX = self.centerX;
}

- (UILabel *)introLabel {
    
    if (!_introLabel) {
        _introLabel = [UILabel new];
        _introLabel.textColor = [UIColor blackColor];
        _introLabel.textAlignment = NSTextAlignmentCenter;
        _introLabel.font = [UIFont systemFontOfSize:15.0f];
        _introLabel.numberOfLines = 2;
    }
    return _introLabel;
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
    }
    return _logoImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = MainColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    return _nameLabel;
}

- (void)setup {
    
    self.introLabel.text = @"开心的锅铲,炒出甜蜜的滋味;\n悦心的调料,调出美满的味道。";
    self.logoImageView.image = [UIImage imageNamed:@"chushi.jpg"];
    self.nameLabel.text = @"Alexander,专业厨师";
}

@end
