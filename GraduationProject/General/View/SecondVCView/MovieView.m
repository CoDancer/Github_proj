//
//  MovieView.m
//  GraduationProject
//
//  Created by onwer on 16/1/25.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "MovieView.h"
#import "StarLevelView.h"
#import "UIImageView+WebCache.h"

@interface MovieView()

@property (nonatomic, strong) UIImageView *movieImageView;
@property (nonatomic, strong) UILabel *movieName;
@property (nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) StarLevelView *starView;

@end

@implementation MovieView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.baseImageView addSubview:self.movieName];
        [self.baseImageView addSubview:self.starView];
        [self addSubview:self.movieImageView];
        [self addSubview:self.baseImageView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.movieImageView.frame = self.bounds;
    self.baseImageView.left = 0;
    self.baseImageView.height = 50;
    self.baseImageView.width = self.width;
    self.baseImageView.bottom = self.bottom;
    
    [self.movieName sizeToFit];
    self.movieName.left = 10;
    self.movieName.centerY = 20;
    
    CGFloat width = 13;
    CGFloat height = 16;
    self.starView.width = 5*width + (5 - 1)*3;
    self.starView.height = height;
    self.starView.right = self.baseImageView.width - 5;
    self.starView.centerY = 35;
}

- (UIImageView *)movieImageView {
    
    if (!_movieImageView) {
        _movieImageView = [UIImageView new];
        _movieImageView.userInteractionEnabled = YES;
        _movieImageView.layer.cornerRadius = 5.0;
    }
    return _movieImageView;
}

- (UIImageView *)baseImageView {
    
    if (!_baseImageView) {
        _baseImageView = [UIImageView new];
        _baseImageView.userInteractionEnabled = YES;
    }
    return _baseImageView;
}

- (UILabel *)movieName {
    
    if (!_movieName) {
        _movieName = [UILabel new];
        _movieName.textColor = [UIColor whiteColor];
        _movieName.font = [UIFont systemFontOfSize:14.0f];
    }
    return _movieName;
}

- (StarLevelView *)starView {
    
    if (!_starView) {
        _starView = [StarLevelView new];
    }
    return _starView;
}

- (void)setModel:(SecondViewCellModel *)model {
    
    _model = model;
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.movieImageView.layer.cornerRadius = 5.0;
    }];
    self.baseImageView.image = [UIImage imageNamed:@"news_blacklayer"];
    self.movieName.text = model.poi_name;
    self.starView.starLevel = [model.fav_count doubleValue];
}

@end
