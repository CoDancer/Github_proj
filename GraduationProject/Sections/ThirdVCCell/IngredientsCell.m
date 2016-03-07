//
//  IngredientsCell.m
//  GraduationProject
//
//  Created by onwer on 16/1/28.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "IngredientsCell.h"

@interface IngredientsCell()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *numbelLabel;
@property (nonatomic, strong) UILabel *kindsLabel;

@end

@implementation IngredientsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.numbelLabel];
        [self.contentView addSubview:self.kindsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.leftImageView.left = 10;
    self.leftImageView.centerY = self.contentView.height/2.0;
    self.leftImageView.size = CGSizeMake(20, 20);
    
    [self.numbelLabel sizeToFit];
    self.numbelLabel.left = self.leftImageView.right + 15;
    self.numbelLabel.centerY = self.contentView.height/2.0;
    
    [self.kindsLabel sizeToFit];
    self.kindsLabel.left = 140 * k_IOS_Scale;
    self.kindsLabel.centerY = self.contentView.height/2.0;
}

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
    }
    return _leftImageView;
}

- (UILabel *)numbelLabel {
    
    if (!_numbelLabel) {
        _numbelLabel = [UILabel new];
        _numbelLabel.textColor = [UIColor blackColor];
        _numbelLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _numbelLabel;
}

- (UILabel *)kindsLabel {
    
    if (!_kindsLabel) {
        _kindsLabel = [UILabel new];
        _kindsLabel.textColor = [UIColor blackColor];
        _kindsLabel.font = [UIFont systemFontOfSize:14.0f];
        _kindsLabel.numberOfLines = 0;
    }
    return _kindsLabel;
}

- (void)setModel:(IngredientsModel *)model {
    
    _model = model;
    self.leftImageView.image = [UIImage imageNamed:@"ingredients.jpg"];
    self.numbelLabel.text = model.howMuch;
    self.kindsLabel.text = model.whatFood;
}

@end
