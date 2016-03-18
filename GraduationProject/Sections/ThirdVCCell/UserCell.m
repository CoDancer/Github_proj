//
//  UserCell.m
//  GraduationProject
//
//  Created by onwer on 16/3/15.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "UserCell.h"

@interface UserCell()

@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *lineView;

@end

@implementation UserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.leftView.size = CGSizeMake(4, 13);
    self.leftView.left = 10;
    self.leftView.centerY = self.contentView.height/2.0;
    [self.titleLabel sizeToFit];
    self.titleLabel.left = self.leftView.right + 15;
    self.titleLabel.centerY = self.leftView.centerY;
    if (self.isSmallSize) {
        self.rightImageView.size = CGSizeMake(22, 22);
        self.rightImageView.right = self.contentView.width - 14;
    }else {
        self.rightImageView.size = CGSizeMake(30, 30);
        self.rightImageView.right = self.contentView.width - 10;
    }
//    self.rightImageView.layer.cornerRadius = self.rightImageView.height/2.0;
//    self.rightImageView.clipsToBounds = YES;
    self.rightImageView.centerY = self.titleLabel.centerY;
    self.lineView.size = CGSizeMake(self.contentView.width - 20, 1.0);
    self.lineView.left = 10;
    self.lineView.bottom = self.contentView.height;
}

- (UIView *)leftView {
    
    if (!_leftView) {
        _leftView = [UIImageView new];
        _leftView.image = [UIImage imageNamed:@"leftImage"];
    }
    return _leftView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}

- (UIImageView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIImageView new];
        _lineView.image = [UIImage imageNamed:@"slider"];
    }
    return _lineView;
}

- (void)setDic:(NSDictionary *)dic {
    
    _dic = dic;
    self.titleLabel.text = dic[@"content"];
    self.rightImageView.image = dic[@"image"];
}

- (void)setIsSmallSize:(BOOL)isSmallSize {
    
    _isSmallSize = isSmallSize;
}

@end
