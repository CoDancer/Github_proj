//
//  BYImproveFlowView.m
//  BYHelperCode
//
//  Created by onwer on 15/10/28.
//  Copyright © 2015年 CoDancer. All rights reserved.
//

#import "BYImproveFlowView.h"
#import "UIImageView+WebCache.h"

@interface BYImproveFlowView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation BYImproveFlowView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.loveBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.left = 0;
    self.imageView.top = 0;
    self.imageView.size = CGSizeMake(self.width, self.height - 50);
    
    self.loveBtn.top = 5;
    self.loveBtn.left = 5;
    self.loveBtn.size = CGSizeMake(20, 20);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.top = self.imageView.bottom + 10;
    self.titleLabel.centerX = self.width/2.0;
    [self.detailLabel sizeToFit];
    self.detailLabel.top = self.titleLabel.bottom + 5;
    self.detailLabel.centerX = self.width/2.0;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)];
        [_imageView addGestureRecognizer:tapGes];
    }
    return _imageView;
}

- (UIButton *)loveBtn {
    
    if (!_loveBtn) {
        _loveBtn = [UIButton new];
        [_loveBtn setBackgroundImage:[UIImage imageNamed:@"discoverList_collection"]
                            forState:UIControlStateNormal];
        [_loveBtn setBackgroundImage:[UIImage imageNamed:@"discoverList_collectionClicked"]
                            forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(loveBtnDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:11.0];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor blackColor];
    }
    return _detailLabel;
}

- (void)setImage:(UIImage *)image model:(ThirdWaterViewModel *)model {

    self.imageView.image = image;
    self.titleLabel.text = model.titleName;
    self.detailLabel.text = model.detailName;
}

- (void)loveBtnDidTap:(UIButton *)sender {
    
    self.loveBtn.selected = !sender.selected;
}

- (void)imageViewDidTap {
    
    
}

@end
