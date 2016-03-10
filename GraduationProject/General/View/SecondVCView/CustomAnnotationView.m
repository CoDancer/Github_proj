//
//  CustomAnnotationView.m
//  GraduationProject
//
//  Created by onwer on 16/3/9.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (instancetype)initWithAnnotation:(nullable id <MKAnnotation>)annotation reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subLabel];
        [self addSubview:self.leftImageView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.leftImageView.size = CGSizeMake(50, 50);
    self.leftImageView.left = 4;
    self.leftImageView.top = 2;
    [self.titleLabel sizeToFit];
    self.titleLabel.top = self.leftImageView.top;
    self.titleLabel.left = self.leftImageView.right + 5;
    [self.subLabel sizeToFit];
    self.subLabel.top = self.titleLabel.bottom + 5;
    self.subLabel.left = self.titleLabel.left;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

- (UILabel *)subLabel {
    
    if (!_subLabel) {
        _subLabel = [UILabel new];
        _subLabel.textColor = [UIColor blackColor];
        _subLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _subLabel;
}

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.image = [UIImage imageNamed:@"circle"];
    }
    return _leftImageView;
}

@end
