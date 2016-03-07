//
//  SectionHeaderView.m
//  GraduationProject
//
//  Created by CoDancer on 16/1/3.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesToView:self];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.rightImageView];
    }
    return self;
}

- (void)addTapGesToView:(UIView *)view {
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewDidTap)];
    [view addGestureRecognizer:tapGes];
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _subTitleLabel.textColor = [UIColor whiteColor];
    }
    return _subTitleLabel;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.userInteractionEnabled = YES;
    }
    return _rightImageView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.left = 10;
    self.titleLabel.centerY = self.height/2.0;

    self.rightImageView.width = 40;
    self.rightImageView.height = 37;
    self.rightImageView.right = SCREEN_WIDTH;
    self.rightImageView.centerY = self.height/2.0;
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.right = SCREEN_WIDTH - self.rightImageView.width + 5;
    self.subTitleLabel.centerY = self.height/2.0;
}

- (void)setHomeModel:(SecondViewModel *)homeModel {
    
    _homeModel = homeModel;
    self.titleLabel.text = homeModel.tag_name;
    self.subTitleLabel.text = homeModel.section_count;
    self.rightImageView.image = [UIImage imageNamed:@"taoge@2x"];
    self.backgroundColor = [UIColor colorWithHexString:homeModel.color alpha:1];
}

- (void)headViewDidTap {
    
    if ([self.headerDelegate respondsToSelector:@selector(sectionHeaderViewDidTap:)]) {
        [self.headerDelegate sectionHeaderViewDidTap:self];
    }
}

@end
