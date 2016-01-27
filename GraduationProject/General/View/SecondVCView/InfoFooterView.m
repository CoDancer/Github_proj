//
//  InfoFooterView.m
//  GraduationProject
//
//  Created by onwer on 16/1/26.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "InfoFooterView.h"

@interface InfoFooterView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *detailTime;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation InfoFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainColor;
        [self addSubview:self.imageView];
        [self addSubview:self.titleName];
        [self addSubview:self.address];
        [self addSubview:self.detailTime];
        [self addSubview:self.rightImageView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageView.size = CGSizeMake(30, 30);
    self.imageView.left = 10;
    self.imageView.centerY = self.height/2.0;
    
    [self.titleName sizeToFit];
    self.titleName.left = self.imageView.right + 10;
    self.titleName.top = 5;
    
    [self.address sizeToFit];
    self.address.left = self.imageView.right + 10;
    self.address.top = self.titleName.bottom + 5;
    
    [self.detailTime sizeToFit];
    self.detailTime.right = SCREEN_WIDTH - 40;
    self.detailTime.centerY = self.height/2.0;
    
    self.rightImageView.size = CGSizeMake(30, 30);
    self.rightImageView.left = self.detailTime.right + 5;
    self.rightImageView.centerY = self.height/2.0;
    
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)titleName {
    
    if (!_titleName) {
        _titleName = [UILabel new];
        _titleName.textColor = [UIColor whiteColor];
        _titleName.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    return _titleName;
}

- (UILabel *)address {
    
    if (!_address) {
        _address = [UILabel new];
        _address.textColor = [UIColor whiteColor];
        _address.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _address;
}

- (UILabel *)detailTime {
    
    if (!_detailTime) {
        _detailTime = [UILabel new];
        _detailTime.textColor = [UIColor whiteColor];
        _detailTime.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _detailTime;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
    }
    return _rightImageView;
}

- (void)initViewWithModel:(SecondInfoPlaceModel *)model titleName:(NSString *)name; {
    
    self.imageView.image = [UIImage imageNamed:@"InfoMap"];
    self.titleName.text = name;
    self.address.text = model.placeName;
    self.detailTime.text = model.time;
    self.rightImageView.image = [UIImage imageNamed:@"taoge@2x"];
}

@end
