//
//  NewsDetailCell.m
//  GraduationProject
//
//  Created by onwer on 16/2/29.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NewsDetailCell.h"
#import "UIImageView+WebCache.h"

@interface NewsDetailCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIImageView *timeIV;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *commentIV;
@property (nonatomic, strong) UILabel *commentNumLabel;
@property (nonatomic, strong) UILabel *markLabel;

@end

@implementation NewsDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.mainLabel];
        [self addSubview:self.sourceLabel];
        [self addSubview:self.timeIV];
        [self addSubview:self.timeLabel];
        [self addSubview:self.commentIV];
        [self addSubview:self.commentNumLabel];
        [self addSubview:self.markLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageView.top = 0;
    self.imageView.height = 125;
    self.imageView.width = self.width;
    
    self.mainLabel.width = self.imageView.width - 10*2;
    [self.mainLabel sizeToFit];
    self.mainLabel.left = 10;
    self.mainLabel.top = self.imageView.bottom + 10;
    
    [self.sourceLabel sizeToFit];
    self.sourceLabel.left = self.mainLabel.left;
    self.sourceLabel.top = self.mainLabel.bottom + 10;
    
    self.timeIV.size = CGSizeMake(12, 12);
    self.timeIV.left = self.sourceLabel.right + 5;
    self.timeIV.centerY = self.sourceLabel.centerY;
    
    [self.timeLabel sizeToFit];
    self.timeLabel.left = self.timeIV.right;
    self.timeLabel.centerY = self.timeIV.centerY;
    
    self.commentIV.size = CGSizeMake(12, 12);
    self.commentIV.left = self.timeLabel.right + 5;
    self.commentIV.centerY = self.timeLabel.centerY;
    
    [self.commentNumLabel sizeToFit];
    self.commentNumLabel.left = self.commentIV.right;
    self.commentNumLabel.centerY = self.commentIV.centerY;
    
    self.markLabel.size = CGSizeMake(35, 14);
    self.markLabel.right = self.width - 10;
    self.markLabel.centerY = self.commentNumLabel.centerY;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)mainLabel {
    
    if (!_mainLabel) {
        _mainLabel = [UILabel new];
        _mainLabel.font = [UIFont systemFontOfSize:16.0f];
        _mainLabel.textColor = [UIColor blackColor];
        _mainLabel.numberOfLines = 0;
    }
    return _mainLabel;
}

- (UILabel *)sourceLabel {
    
    if (!_sourceLabel) {
        _sourceLabel = [UILabel new];
        _sourceLabel.font = [UIFont systemFontOfSize:10.0f];
        _sourceLabel.textColor = [UIColor lightGrayColor];
    }
    return _sourceLabel;
}

- (UIImageView *)timeIV {
    
    if (!_timeIV) {
        _timeIV = [UIImageView new];
        _timeIV.image = [UIImage imageNamed:@"InfoTime"];
    }
    return _timeIV;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:10.0f];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}

- (UIImageView *)commentIV {
    
    if (!_commentIV) {
        _commentIV = [UIImageView new];
        _commentIV.image = [UIImage imageNamed:@"comments"];
    }
    return _commentIV;
}

- (UILabel *)commentNumLabel {
    
    if (!_commentNumLabel) {
        _commentNumLabel = [UILabel new];
        _commentNumLabel.font = [UIFont systemFontOfSize:10.0f];
        _commentNumLabel.textColor = [UIColor lightGrayColor];
        _commentNumLabel.text = @"10";
    }
    return _commentNumLabel;
}

- (UILabel *)markLabel {
    
    if (!_markLabel) {
        _markLabel = [UILabel new];
        _markLabel.font = [UIFont systemFontOfSize:10.0f];
        _markLabel.text = @"推荐";
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.textColor = MainColor;
        _markLabel.layer.cornerRadius = 2.0;
        _markLabel.clipsToBounds = YES;
        _markLabel.layer.borderWidth = 1.0f;
        _markLabel.layer.borderColor = MainColor.CGColor;
    }
    return _markLabel;
}

- (void)setDetailModel:(NewsDetailModel *)detailModel {
    
    _detailModel = detailModel;
    if (![detailModel.imageUrl isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:detailModel.imageUrl]];
    }else {
        self.imageView.image = [UIImage imageNamed:@"noImage.jpg"];
    }
    self.mainLabel.height = detailModel.textHeight;
    self.mainLabel.text = detailModel.titleStr;
    self.sourceLabel.text = detailModel.sourceStr;
    self.timeLabel.text = detailModel.timeStr;
}

@end
